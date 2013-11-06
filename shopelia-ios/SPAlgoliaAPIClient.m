//
//  SPAlgoliaAPIClient.m
//  shopelia-ios
//
//  Created by Nicolas on 29/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAlgoliaAPIClient.h"
#import "ASAPIClient.h"
#import "SPAlgoliaSearchResult.h"

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
        _APIClient = [ASAPIClient apiClientWithApplicationID:SPAlgoliaApplicationID apiKey:SPAlgoliaAPIKey];
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

- (void)searchProductsWithQuery:(NSString *)query page:(NSUInteger)page completion:(void (^)(BOOL success, NSArray *searchResults))completion
{
    // perform search
    [self.remoteIndex search:[ASQuery queryWithFullTextQuery:query]
                     success:^(ASRemoteIndex *index, ASQuery *query, NSDictionary *result) {
                         
                         // create products
                         NSMutableArray *searchResults = [[NSMutableArray alloc] init];
                         for (NSDictionary *productJSON in [result objectForKey:@"hits"])
                         {
                             if (![productJSON isKindOfClass:[NSDictionary class]])
                                 continue ;
                             
                             SPAlgoliaSearchResult *searchResult = [[SPAlgoliaSearchResult alloc] initWithJSON:productJSON];
                             if ([searchResult isValid] && ![searchResults containsObject:searchResult])
                                 [searchResults addObject:searchResult];
                         }
                         if (completion)
                             completion(YES, searchResults);
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
