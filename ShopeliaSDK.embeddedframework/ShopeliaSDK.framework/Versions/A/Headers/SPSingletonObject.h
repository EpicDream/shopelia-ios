//
//  SPSingletonObject.h
//  ShopeliaSDK
//
//  Created by Nicolas on 26/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSingletonObject : NSObject

// returns the shared instance
+ (instancetype)sharedInstance;

// flushes all the living instances
+ (void)flushInstances;

@end
