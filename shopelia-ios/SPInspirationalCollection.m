//
//  SPInspirationalCollection.m
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPInspirationalCollection.h"

@implementation SPInspirationalCollection

#pragma mark - Model object

- (BOOL)isValid
{
    return (self.UUID && self.imageURL);
}

#pragma mark - JSON

- (BOOL)configureWithJSON:(NSDictionary *)JSON
{
    BOOL configure = [super configureWithJSON:JSON];
    
    if (configure)
    {
        self.name = [SPJSONFactory stringValueForJSONObject:[JSON objectForKey:@"name"]];
        self.UUID = [SPJSONFactory stringValueForJSONObject:[JSON objectForKey:@"uuid"]];
        self.imageURL = [SPJSONFactory URLValueForJSONObject:[JSON objectForKey:@"image_url"]];
    }
    return configure;
}

@end
