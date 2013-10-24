//
//  SPProductHelper.h
//  ShopeliaSDK
//
//  Created by Nicolas on 03/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPAPIRequest.h"
#import "SPProduct.h"
#import "SPAPIError.h"

@interface SPProductHelper : NSObject

+ (SPAPIRequest *)fetchProduct:(SPProduct *)product
                availableBlock:(void (^)(SPProduct *product))availableBlock
               completionBlock:(void (^)(SPAPIError *error, BOOL timeout))completionBlock;

@end
