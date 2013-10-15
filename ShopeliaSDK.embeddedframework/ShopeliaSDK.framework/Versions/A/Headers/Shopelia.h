//
//  Shopelia.h
//  ShopeliaSDK
//
//  Created by Nicolas on 06/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Shopelia : NSObject

// returns the current framework version string
+ (NSString *)frameworkVersionString;

// asks Shopelia to prepare a new order with the given URL
- (void)prepareOrderWithProductURL:(NSURL *)productURL completion:(void(^)(NSError *error))block;

// presents Shopelia to checkout the previous prepared order
- (NSError *)checkoutPreparedOrderFromViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;

@end
