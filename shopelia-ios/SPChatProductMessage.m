//
//  SPChatProductMessage.m
//  shopelia-ios
//
//  Created by Nicolas on 15/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatProductMessage.h"

@implementation SPChatProductMessage

#pragma mark - Message

- (BOOL)isValid
{
    return ([super isValid] && self.price && self.URL && self.imageURL && self.name);
}

- (NSString *)displayCellIdentifier
{
    return @"SPChatSenderProductMessageTableViewCell";
}

#pragma mark - JSON

- (NSDictionary *)JSONReprensentation
{
    NSMutableDictionary *dictionnary = [[super JSONReprensentation] mutableCopy];
    
    if (self.URL)
        [dictionnary setObject:[self.URL absoluteString] forKey:@"product_url"];
    if (self.imageURL)
        [dictionnary setObject:[self.imageURL absoluteString] forKey:@"image_url"];
    if (self.price)
        [dictionnary setObject:self.price forKey:@"price"];
    if (self.name)
        [dictionnary setObject:self.name forKey:@"name"];
    return dictionnary;
}

- (BOOL)configureWithJSON:(NSDictionary *)JSON
{
    BOOL configure = [super configureWithJSON:JSON];
    
    if (configure)
    {
        self.URL = [SPJSONFactory URLValueForJSONObject:[JSON objectForKey:@"product_url"]];
        self.imageURL = [SPJSONFactory URLValueForJSONObject:[JSON objectForKey:@"image_url"]];
        self.name = [SPJSONFactory stringValueForJSONObject:[JSON objectForKey:@"name"]];
        self.price = [SPJSONFactory decimalNumberValueForJSONObject:[JSON objectForKey:@"price"]];
    }
    return configure;
}

@end
