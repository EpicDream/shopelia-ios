//
//  SPColor.h
//  ShopeliaSDK
//
//  Created by Nicolas on 01/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPColor : NSObject

// returns a lighter color of the given color
+ (UIColor *)lighterColorForColor:(UIColor *)color;

// returns a darker color of the given color
+ (UIColor *)darkerColorForColor:(UIColor *)color;

@end
