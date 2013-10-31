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

@end
