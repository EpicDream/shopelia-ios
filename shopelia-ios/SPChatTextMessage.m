//
//  SPChatTextMessage.m
//  shopelia-ios
//
//  Created by Nicolas on 14/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatTextMessage.h"

@implementation SPChatTextMessage

#pragma mark - Message

- (BOOL)isValid
{
    return ([super isValid] && self.message);
}

- (NSString *)displayCellIdentifier
{
    if ([self fromAgent])
        return @"SPChatSenderTextMessageTableViewCell";
    return @"SPChatReceiverTextMessageTableViewCell";
}

#pragma mark - JSON

- (NSDictionary *)JSONReprensentation
{
    NSMutableDictionary *dictionnary = [[super JSONReprensentation] mutableCopy];
    
    if (self.message)
        [dictionnary setObject:self.message forKey:@"message"];
    return dictionnary;
}

- (BOOL)configureWithJSON:(NSDictionary *)JSON
{
    BOOL configure = [super configureWithJSON:JSON];
    
    if (configure)
    {
        self.message = [SPJSONFactory stringValueForJSONObject:[JSON objectForKey:@"message"]];
    }
    return configure;
}

@end
