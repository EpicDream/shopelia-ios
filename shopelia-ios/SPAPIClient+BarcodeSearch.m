//
//  SPAPIClient+BarcodeSearch.m
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAPIClient+BarcodeSearch.h"
#import "SPAPIClient+Tracker.h"
#import "SPAPIFetchProductWithBarCodeError.h"

@implementation SPAPIClient (BarcodeSearch)

- (SPAPIRequest *)fetchProductWithBarcode:(NSString *)barcode fromScanner:(BOOL)fromScanner completion:(void (^)(SPAPIError *error, NSDictionary *product))completion
{
    // request
    SPAPIRequest *request = [self defaultRequest];
    [request setURL:[self.baseURL URLByAppendingPathComponent:@"api/showcase/products/search"]];
    [request setHTTPMethod:@"GET"];
    [request setURLParameters:@{@"ean" : barcode, @"tracker" : [self tracker]}];
  
    [request startWithCompletion:^(NSError *error, SPAPIResponse *response) {
        // check errors
        SPAPIFetchProductWithBarCodeError *APIError = [[SPAPIFetchProductWithBarCodeError alloc] init];
        [APIError setFromScanner:fromScanner];
        [APIError processError:error response:response];
        if ([APIError hasError])
        {
            if (completion)
                completion(APIError, nil);
            return ;
        }
        
        // return product
        NSMutableDictionary *JSON = [[response responseJSON] mutableCopy];
        
        // epur URLs
        NSArray *productURLs = [JSON objectForKey:@"urls"];
        NSMutableArray *epuredProductURLs = [[NSMutableArray alloc] init];
        for (NSString *productURL in productURLs)
        {
            if (![epuredProductURLs containsObject:productURL])
                [epuredProductURLs addObject:productURL];
        }
        [JSON setObject:epuredProductURLs forKey:@"urls"];
        
        if (completion)
            completion(nil, JSON);
    }];
    return request;
}

@end
