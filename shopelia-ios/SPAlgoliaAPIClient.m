//
//  SPAlgoliaAPIClient.m
//  shopelia-ios
//
//  Created by Nicolas on 29/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAlgoliaAPIClient.h"
#import "ASAPIClient.h"

@interface SPAlgoliaAPIClient ()
@property (strong, nonatomic) ASAPIClient *APIClient;
@property (strong, nonatomic) ASRemoteIndex *remoteIndex;
@end

@implementation SPAlgoliaAPIClient

#pragma mark - Lazy instantiation

- (ASAPIClient *)APIClient
{
    if (!_APIClient)
    {
        _APIClient = [ASAPIClient apiClientWithApplicationID:@"JUFLKNI0PS" apiKey:@"03832face9510ee5a495b06855dfa38b"];
    }
    return _APIClient;
}

- (ASRemoteIndex *)remoteIndex
{
    if (!_remoteIndex)
    {
        _remoteIndex = [self.APIClient getIndex:@"products-feed-fr"];
    }
    return _remoteIndex;
}

#pragma mark - Requests helpers

- (void)cancelSearches
{
    [self.remoteIndex cancelPreviousSearches];
}

- (void)searchProductsWithQuery:(NSString *)query page:(NSUInteger)page completion:(void (^)(BOOL success, NSArray *products))completion
{
    // cancel previous searches
    [self cancelSearches];
    
    // perform search
    [self.remoteIndex search:[ASQuery queryWithFullTextQuery:query]
                     success:^(ASRemoteIndex *index, ASQuery *query, NSDictionary *result) {
                         
                         // create products
                         NSMutableArray *products = [[NSMutableArray alloc] init];
                         for (NSDictionary *productJSON in [result objectForKey:@"hits"])
                         {
                             if (![productJSON isKindOfClass:[NSDictionary class]])
                                 continue ;
                             
                             SPProduct *product = [[SPProduct alloc] initWithMinimalJSON:productJSON];
                             if ([product isValid])
                                 [products addObject:product];
                         }
                         if (completion)
                             completion(YES, products);
                     }
                     failure:^(ASRemoteIndex *index, ASQuery *query, NSString *errorMessage) {
                         
                         // notify
                         if (completion)
                             completion(NO, nil);
                     }];
}

- (void)dealloc
{
    [self cancelSearches];
}

@end
