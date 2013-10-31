//
//  SPAPIClient+InspirationalCollections.h
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

@interface SPAPIClient (InspirationalCollections)

- (SPAPIRequest *)fetchInspirationalCollections:(NSArray *)tags completion:(void (^)(SPAPIError *error, NSArray *collections))completion;

@end
