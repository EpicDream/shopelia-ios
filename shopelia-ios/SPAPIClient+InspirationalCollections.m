//
//  SPAPIClient+InspirationalCollections.m
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAPIClient+InspirationalCollections.h"
#import "SPAPIFetchInspirationalCollectionsError.h"
#import "SPInspirationalCollection.h"
#import "SPFetchInspirationalCollectionProductsError.h"

@implementation SPAPIClient (InspirationalCollections)

- (SPAPIRequest *)fetchInspirationalCollections:(NSArray *)tags completion:(void (^)(SPAPIError *error, NSArray *collections))completion
{
    // request
    SPAPIRequest *request = [self defaultRequest];
    [request setURL:[self.baseURL URLByAppendingPathComponent:@"api/collections"]];
    [request setHTTPMethod:@"GET"];
    [request setURLParameters:@{@"tags" : tags}];
    [request startWithCompletion:^(NSError *error, SPAPIResponse *response) {
        // check errors
        SPAPIFetchInspirationalCollectionsError *APIError = [[SPAPIFetchInspirationalCollectionsError alloc] initWithError:error response:response];
        if ([APIError hasError])
        {
            if (completion)
                completion(APIError, nil);
            return ;
        }
        
        // return collections
        NSArray *JSON = [response responseJSON];
        NSMutableArray *collections = [[NSMutableArray alloc] init];
        
        for (NSDictionary *collectionJSON in JSON)
        {
            SPInspirationalCollection *collection = [[SPInspirationalCollection alloc] initWithJSON:collectionJSON];
            if ([collection isValid])
                [collections addObject:collection];
        }
        if (completion)
            completion(nil, collections);
    }];
    return request;
}

- (SPAPIRequest *)fetchInspirationalCollectionProducts:(SPInspirationalCollection *)collection completion:(void (^)(SPAPIError *error, NSArray *products))completion
{
    // request
    NSURL *URL = [[self.baseURL URLByAppendingPathComponent:@"api/collections"] URLByAppendingPathComponent:collection.UUID];
    SPAPIRequest *request = [self defaultRequest];
    [request setURL:URL];
    [request setHTTPMethod:@"GET"];
    [request startWithCompletion:^(NSError *error, SPAPIResponse *response) {
        // check errors
        SPFetchInspirationalCollectionProductsError *APIError = [[SPFetchInspirationalCollectionProductsError alloc] initWithError:error response:response];
        if ([APIError hasError])
        {
            if (completion)
                completion(APIError, nil);
            return ;
        }
        
        // return collections
        NSArray *JSON = [response responseJSON];
        NSMutableArray *products = [[NSMutableArray alloc] init];
        NSDecimalNumber *divider = [NSDecimalNumber decimalNumberWithString:@"1"];
        
        for (NSDictionary *productJSON in JSON)
        {
            SPProduct *product = [[SPProduct alloc] initWithMinimalJSON:productJSON pricesDivider:divider];
            if ([product isValid])
                [products addObject:product];
        }
        if (completion)
            completion(nil, products);
    }];
    return request;
}

@end
