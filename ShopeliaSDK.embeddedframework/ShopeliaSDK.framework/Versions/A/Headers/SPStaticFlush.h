//
//  SPStaticFlush.h
//  ShopeliaSDK
//
//  Created by Nicolas on 26/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPStaticFlush <NSObject>

// asks the receiver to flush its internal static variables
+ (void)flushStaticVariables;

@end
