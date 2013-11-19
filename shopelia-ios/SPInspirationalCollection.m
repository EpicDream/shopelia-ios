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

- (NSDictionary *)JSONReprensentation
{
    NSMutableDictionary *dictionnary = [[NSMutableDictionary alloc] init];
    
    if (self.imageURL)
        [dictionnary setObject:[self.imageURL absoluteString] forKey:@"image_url"];
    [dictionnary setObject:[NSString stringWithFormat:@"%.0fx%.0f", self.imageSize.width, self.imageSize.height] forKey:@"image_size"];
    if (self.name)
        [dictionnary setObject:self.name forKey:@"name"];
    if (self.UUID)
        [dictionnary setObject:self.UUID forKey:@"uuid"];
    return dictionnary;
}

- (BOOL)configureWithJSON:(NSDictionary *)JSON
{
    BOOL configure = [super configureWithJSON:JSON];

    if (configure)
    {
        self.name = [SPJSONFactory stringValueForJSONObject:[JSON objectForKey:@"name"]];
        self.UUID = [SPJSONFactory stringValueForJSONObject:[JSON objectForKey:@"uuid"]];
        if (!self.UUID)
            self.UUID = [SPJSONFactory stringValueForJSONObject:[JSON objectForKey:@"collection_uuid"]];
        self.imageURL = [SPJSONFactory URLValueForJSONObject:[JSON objectForKey:@"image_url"]];
    
        // image size
        NSString *imageSize = [SPJSONFactory stringValueForJSONObject:[JSON objectForKey:@"image_size"]];
        CGSize readImageSize = CGSizeZero;
        NSArray *components = [imageSize componentsSeparatedByString:@"x"];
        if (components.count == 2)
        {
            readImageSize.width = [[components objectAtIndex:0] floatValue];
            readImageSize.height = [[components objectAtIndex:1] floatValue];
        }
        self.imageSize = readImageSize;
    }
    return configure;
}

@end
