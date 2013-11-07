//
//  SPAlgoliaAPIClient.h
//  shopelia-ios
//
//  Created by Nicolas on 29/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAlgoliaAPIClient : SPSingletonObject

// performs a search request
- (void)searchProductsWithQuery:(NSString *)query page:(NSUInteger)page completion:(void (^)(BOOL success, NSArray *searchResults, NSUInteger pagesNumber))completion;

// cancels all the searches
- (void)cancelSearches;

// returns whether algolia is currently busy
- (BOOL)isSearching;

@end
