//
//  SPChatCollectionMessage.m
//  shopelia-ios
//
//  Created by Nicolas on 15/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatCollectionMessage.h"

@implementation SPChatCollectionMessage

#pragma mark - Message

- (BOOL)isValid
{
    return ([super isValid] && [self.collection isValid]);
}

- (NSString *)displayCellIdentifier
{
    return @"SPChatSenderCollectionMessageTableViewCell";
}

#pragma mark - JSON

- (NSDictionary *)JSONReprensentation
{
    NSMutableDictionary *dictionnary = [[super JSONReprensentation] mutableCopy];

    if (self.collection)
        [dictionnary setObject:[self.collection JSONReprensentation] forKey:@"collection"];
    return dictionnary;
}

- (BOOL)configureWithJSON:(NSDictionary *)JSON
{
    BOOL configure = [super configureWithJSON:JSON];
    
    if (configure)
    {
        self.collection = [[SPInspirationalCollection alloc] initWithJSON:[JSON objectForKey:@"collection"]];
    }
    return configure;
}

@end
