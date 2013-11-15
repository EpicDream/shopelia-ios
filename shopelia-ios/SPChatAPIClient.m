//
//  SPChatAPIClient.m
//  shopelia-ios
//
//  Created by Nicolas on 12/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatAPIClient.h"

#define SPChatPreferencesMessagesKey @"messages"

@interface SPChatAPIClient ()
@property (strong, nonatomic) SPPreferencesManager *preferences;
@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) SPAPIRequest *fetchMessagesRequest;
@end

@implementation SPChatAPIClient

#pragma mark - Lazy instantiation

- (SPPreferencesManager *)preferences
{
    if (!_preferences)
    {
        _preferences = [[SPPreferencesManager alloc] initWithFilename:@"chat"];
    }
    return _preferences;
}

- (NSMutableArray *)messages
{
    if (!_messages)
    {
        [self loadMessagesFromPreferences];
    }
    return _messages;
}

#pragma mark - Preferences management

- (void)writeMessagesToPreferences
{
    NSMutableArray *messagesJSON = [[NSMutableArray alloc] init];
    
    for (SPChatMessage *message in self.messages)
        [messagesJSON addObject:[message JSONReprensentation]];
    [self.preferences setObject:messagesJSON forKey:SPChatPreferencesMessagesKey];
    
    // send notification
    [[NSNotificationCenter defaultCenter] postNotificationName:SPChatAPIClientMessageListUpdatedNotification object:nil];
}

- (void)loadMessagesFromPreferences
{
    NSArray *messagesJSON = [self.preferences objectForKey:SPChatPreferencesMessagesKey];
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    
    for (NSDictionary *messageJSON in messagesJSON)
    {
        Class messageClass = NSClassFromString([messageJSON objectForKey:@"message_class"]);
        id message = [[messageClass alloc] initWithJSON:messageJSON];
        
        if ([message isValid])
            [messages addObject:message];
    }
    self.messages = messages;
}

#pragma mark - JSON

- (NSArray *)messagesFromMessageJSON:(NSDictionary *)JSON
{
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    
    // text messages
    SPChatTextMessage *textMessage = [[SPChatTextMessage alloc] initWithJSON:JSON];
    if ([textMessage isValid])
        [messages addObject:textMessage];
    
    // product messages
    for (NSDictionary *productJSON in [JSON objectForKey:@"products"])
    {
        NSMutableDictionary *productMessageJSON = [JSON mutableCopy];
        [productMessageJSON addEntriesFromDictionary:productJSON];
        SPChatProductMessage *productMessage = [[SPChatProductMessage alloc] initWithJSON:productMessageJSON];
        if ([productMessage isValid])
            [messages addObject:productMessage];
    }
    
    // collection messages
    NSDictionary *collectionJSON = [JSON objectForKey:@"collection"];
    if (collectionJSON)
    {
        SPChatCollectionMessage *collectionMessage = [[SPChatCollectionMessage alloc] initWithJSON:JSON];
        if ([collectionMessage isValid])
            [messages addObject:collectionMessage];
    }
    
    
    // configure messages
    for (SPChatMessage *message in messages)
    {
        [message setStatus:SPChatMessageDeliveryStatusSending state:NO];
        [message setStatus:SPChatMessageDeliveryStatusSent state:YES];
    }
    
    return messages;
}

- (NSArray *)messagesFromJSON:(NSArray *)JSON
{
    if (![JSON isKindOfClass:[NSArray class]])
        return nil;
    
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    for (NSDictionary *messageJSON in JSON)
        [messages addObjectsFromArray:[self messagesFromMessageJSON:messageJSON]];
    
    // sort messages
    return [messages sortedArrayUsingComparator:^NSComparisonResult(SPChatMessage *obj1, SPChatMessage *obj2) {
        return [obj1.timestamp compare:obj2.timestamp];
    }];
}

#pragma mark - Messages management

- (NSArray *)allMessages
{
    return self.messages;
}

- (void)clearAllMessages
{
    [self.messages removeAllObjects];
    [self writeMessagesToPreferences];
}

- (void)sendTextMessage:(SPChatTextMessage *)message
{
    // add message to list
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    [message setTimestamp:[NSNumber numberWithDouble:now]];
    [message setID:@0];
    [message setStatus:SPChatMessageDeliveryStatusSending state:YES];
    [message setStatus:SPChatMessageDeliveryStatusSent state:NO];
    [self.messages addObject:message];
    [self writeMessagesToPreferences];
    
    // send request
    SPAPIRequest *request = [self defaultRequest];
    [request setHTTPMethod:@"POST"];
    [request setURL:[self.baseURL URLByAppendingPathComponent:@"/api/georges/messages"]];
    [request setHTTPBodyParameters:[message JSONReprensentation]];
    [request startWithCompletion:^(NSError *error, id response) {
        // mark message as sent (or not)
        if (error || [response statusCode] != 200)
            [message setStatus:SPChatMessageDeliveryStatusSent state:NO];
        else
            [message setStatus:SPChatMessageDeliveryStatusSent state:YES];

        // mark message as not sending
        [message setStatus:SPChatMessageDeliveryStatusSending state:NO];
        [self writeMessagesToPreferences];
    }];
}

- (void)receiveMessages:(NSArray *)messages fromMessage:(SPChatMessage *)message
{
    // if no messages
    if (messages.count == 0)
        return ;
    
    if (message)
    {
        // get index of last sent message
        NSUInteger indexOfLastSentMessage = [self.messages indexOfObject:message];
        if (indexOfLastSentMessage == NSNotFound)
            return ;
        
        // insert received messages between sent and not sent messages
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexOfLastSentMessage + 1, messages.count)];
        [self.messages insertObjects:messages atIndexes:indexSet];
    }
    else
    {
        // insert received messages between sent and not sent messages
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, messages.count)];
        [self.messages insertObjects:messages atIndexes:indexSet];
    }
    [self writeMessagesToPreferences];
}

- (SPChatMessage *)lastSentMessage
{
    for (NSInteger i = self.messages.count - 1; i >= 0; i--)
    {
        SPChatMessage *message = [self.messages objectAtIndex:i];
        
        if ([message statusState:SPChatMessageDeliveryStatusSent])
            return message;
    }
    return nil;
}

- (void)fetchNewMessages
{
    [self.fetchMessagesRequest cancelAndClearCompletionBlock];
    self.fetchMessagesRequest = nil;
    
    // get last sent message timestamp
    SPChatMessage *lastSentMessage = [self lastSentMessage];
    NSNumber *lastSentTimestamp = lastSentMessage ? [NSNumber numberWithUnsignedLongLong:([lastSentMessage.timestamp unsignedLongLongValue]) + 1] : @0;
    
    // send request
    self.fetchMessagesRequest = [self defaultRequest];
    [self.fetchMessagesRequest setHTTPMethod:@"GET"];
    [self.fetchMessagesRequest setURL:[self.baseURL URLByAppendingPathComponent:@"/api/georges/messages"]];
    [self.fetchMessagesRequest setURLParameters:@{@"timestamp" : [lastSentTimestamp stringValue]}];
    [self.fetchMessagesRequest startWithCompletion:^(NSError *error, id response) {
        if (error || [response statusCode] != 200)
            return ;
        
        // treat messages
        NSArray *receivedMessages = [self messagesFromJSON:[response responseJSON]];
        [self receiveMessages:receivedMessages fromMessage:lastSentMessage];
        
        [self.fetchMessagesRequest cancelAndClearCompletionBlock];
        self.fetchMessagesRequest = nil;
    }];
}

@end