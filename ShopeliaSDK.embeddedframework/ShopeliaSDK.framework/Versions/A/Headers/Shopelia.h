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

// string to represent the tracker used for the developer analytics 
@property (strong, nonatomic) NSString *tracker;

// returns whether the framework is able to checkout orders based the current iOS version
+ (BOOL)canCheckoutOrders;

// returns the current framework version string
+ (NSString *)frameworkVersionString;

// asks Shopelia to prepare a new order with the given URL
- (void)prepareOrderWithProductURL:(NSURL *)productURL completion:(void(^)(NSError *error))block;

// presents Shopelia to checkout the previous prepared order
- (NSError *)checkoutPreparedOrderFromViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)(void))completion;

@end
