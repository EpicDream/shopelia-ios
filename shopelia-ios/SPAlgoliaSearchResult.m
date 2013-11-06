//
//  SPAlgoliaSearchResult.m
//  shopelia-ios
//
//  Created by Nicolas on 30/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAlgoliaSearchResult.h"

@implementation SPAlgoliaSearchResult

#pragma mark - Model object

- (BOOL)isValid
{
    return (self.product.isValid);
}

- (BOOL)isEqual:(SPAlgoliaSearchResult *)object
{
    if (self.barcode == nil || object.barcode == nil)
        return NO;
    return [object.barcode isEqualToString:self.barcode];
}

#pragma mark - JSON

- (BOOL)configureWithJSON:(NSDictionary *)JSON
{
    BOOL configure = [super configureWithJSON:JSON];
    
    if (configure)
    {
        self.product = [[SPProduct alloc] initWithMinimalJSON:JSON pricesDivider:[NSDecimalNumber decimalNumberWithString:@"100"]];
        
        for (NSString *string in [JSON objectForKey:@"_tags"])
        {
            NSString *value = [SPJSONFactory stringValueForJSONObject:string];
            if ([value hasPrefix:@"ean:"])
            {
                self.barcode = [value stringByReplacingOccurrencesOfString:@"ean:" withString:@""];
                break ;
            }
        }
    }
    return configure;
}

@end
