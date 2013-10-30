//
//  SPAPIClient+ProductPrices.m
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAPIClient+ProductPrices.h"
#import "SPAPIFetchProductPricesError.h"

@implementation SPAPIClient (ProductPrices)

- (SPAPIRequest *)fetchProductPrices:(NSArray *)productURLs completion:(void (^)(BOOL timeout, SPAPIError *error, NSArray *products))completion
{
    // request
    SPAPIRequest *request = [self defaultRequest];
    [request setIgnoresNetworkActivityIndicator:YES];
    [request setURL:[self.baseURL URLByAppendingPathComponent:@"api/products"]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBodyParameters:@{@"urls" : productURLs}];

    // poll for products
    [SPHTTPPoller pollRequest:request maxTime:20.0f requestInterval:1.0f restartBlock:^(BOOL *restart, SPAPIResponse *response) {
        // check errors
        SPAPIFetchProductPricesError *APIError = [[SPAPIFetchProductPricesError alloc] initWithError:nil response:response];
        *restart = [APIError hasError];
    } completionBlock:^(BOOL timeout, NSError *error, SPAPIResponse *response) {
        if (timeout)
        {
            if (completion)
                completion(YES, nil, nil);
            return ;
        }
        
        // check errors
        SPAPIFetchProductPricesError *APIError = [[SPAPIFetchProductPricesError alloc] initWithError:error response:response];
        if ([APIError hasError])
        {
            if (completion)
                completion(NO, APIError, nil);
            return ;
        }
        
        // return products
        NSArray *JSON = [response responseJSON];
        NSMutableArray *products = [[NSMutableArray alloc] init];
        
        for (NSDictionary *productJSON in JSON)
        {
            SPProduct *product = [[SPProduct alloc] initWithJSON:productJSON];
            if ([product isValid])
                [products addObject:product];
        }
        if (completion)
            completion(NO, nil, [products sortedArrayUsingComparator:^NSComparisonResult(SPProduct *obj1, SPProduct* obj2) {
                return [[obj1 totalPrice] compare:[obj2 totalPrice]];
            }]);
    }];
    
    return request;
}

@end
