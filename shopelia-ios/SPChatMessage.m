//
//  SPChatMessage.m
//  shopelia-ios
//
//  Created by Nicolas on 14/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatMessage.h"

@implementation SPChatMessage

#pragma mark - Message

- (BOOL)isValid
{
    return ([super isValid] && self.ID && self.timestamp);
}

- (BOOL)statusState:(SPChatMessageStatus)status
{
    return ((self.messageStatus & status) == status);
}

- (void)setStatus:(SPChatMessageStatus)status state:(BOOL)enabled
{
    if ([self statusState:status] == enabled)
        return ;
    
    self.messageStatus = (self.messageStatus ^ status);
}

- (NSString *)displayCellIdentifier
{
    return nil;
}

#pragma mark - JSON

- (NSDictionary *)JSONReprensentation
{
    NSMutableDictionary *dictionnary = [[NSMutableDictionary alloc] init];
    
    if (self.ID)
        [dictionnary setObject:self.ID forKey:@"message_id"];
    [dictionnary setObject:[NSNumber numberWithBool:self.fromAgent] forKey:@"georges"];
    [dictionnary setObject:NSStringFromClass([self class]) forKey:@"message_class"];
    [dictionnary setObject:[NSNumber numberWithUnsignedInteger:self.messageStatus] forKey:@"status"];
    if (self.timestamp)
        [dictionnary setObject:self.timestamp forKey:@"timestamp"];
    return dictionnary;
}

- (BOOL)configureWithJSON:(NSDictionary *)JSON
{
    BOOL configure = [super configureWithJSON:JSON];
    
    if (configure)
    {
        self.ID = [SPJSONFactory numberValueForJSONObject:[JSON objectForKey:@"message_id"]];
        self.timestamp = [SPJSONFactory numberValueForJSONObject:[JSON objectForKey:@"timestamp"]];
        self.fromAgent = [SPJSONFactory boolValueForJSONObject:[JSON objectForKey:@"georges"]];
        self.messageStatus = [[SPJSONFactory numberValueForJSONObject:[JSON objectForKey:@"status"]] unsignedIntegerValue];
    }
    return configure;
}

@end
