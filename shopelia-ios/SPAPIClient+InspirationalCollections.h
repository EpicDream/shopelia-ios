//
//  SPAPIClient+InspirationalCollections.h
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPInspirationalCollection.h"

@interface SPAPIClient (InspirationalCollections)

// returns all the inspirational collections
- (SPAPIRequest *)fetchInspirationalCollections:(NSArray *)tags completion:(void (^)(SPAPIError *error, NSArray *collections))completion;

// returns all of an inspirational collection products
- (SPAPIRequest *)fetchInspirationalCollectionProducts:(SPInspirationalCollection *)collection completion:(void (^)(SPAPIError *error, NSArray *products))completion;

@end
