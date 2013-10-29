//
//  SPAPIClient+ProductPrices.h
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

@interface SPAPIClient (ProductPrices)

- (SPAPIRequest *)fetchProductPrices:(NSArray *)productURLs completion:(void (^)(BOOL timeout, SPAPIError *error, NSArray *products))completion;

@end
