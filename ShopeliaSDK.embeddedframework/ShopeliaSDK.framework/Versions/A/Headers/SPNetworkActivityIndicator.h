//
//  SPNetworkActivityIndicator.h
//  ShopeliaSDK
//
//  Created by Nicolas on 23/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPNetworkActivityIndicator : NSObject

// increments the number of running requests count
+ (void)incrementRunningRequestsCount;

// decrements the number of running requests count
+ (void)decrementRunningRequestsCount;

@end
