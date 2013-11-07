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
@property (assign, nonatomic, getter = isSearching) BOOL searching;
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
    self.searching = NO;
}

- (void)searchProductsWithQuery:(NSString *)query page:(NSUInteger)page completion:(void (^)(BOOL success, NSArray *searchResults, NSUInteger pagesNumber))completion
{
    // perform search
    ASQuery *algoliaQuery = [ASQuery queryWithFullTextQuery:query];
    algoliaQuery.page = page;
    
    self.searching = YES;
    [self.remoteIndex search:algoliaQuery
                     success:^(ASRemoteIndex *index, ASQuery *query, NSDictionary *result) {
                         self.searching = NO;

                         NSUInteger nbPages = 0;
                         nbPages = [[result objectForKey:@"nbPages"] integerValue];
                         
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
                             completion(YES, searchResults, nbPages);
                     }
                     failure:^(ASRemoteIndex *index, ASQuery *query, NSString *errorMessage) {
                         self.searching = NO;
                         
                         // notify
                         if (completion)
                             completion(NO, nil, 0);
                     }];
}

- (void)dealloc
{
    [self cancelSearches];
}

@end
