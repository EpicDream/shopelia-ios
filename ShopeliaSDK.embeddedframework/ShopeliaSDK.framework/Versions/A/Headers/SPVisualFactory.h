//
//  SPVisualFactory.h
//  ShopeliaSDK
//
//  Created by Nicolas on 05/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SPStaticFlush.h"

@interface SPVisualFactory : NSObject <SPStaticFlush>

+ (UIImage *)cachedImageNamed:(NSString *)name;

+ (NSString *)regularFontName;
+ (NSString *)lightFontName;
+ (NSString *)boldFontName;

+ (UIColor *)defaultBackgroundColor;
+ (UIColor *)normalTextColor;
+ (UIColor *)greyTextColor;
+ (UIColor *)darkGreyTextColor;
+ (UIColor *)brightTextColor;
+ (UIColor *)linkTextColor;
+ (UIColor *)importantTextColor;
+ (UIColor *)navigationBarBackgroundColor;
+ (UIColor *)fieldPlaceholderTextColor;
+ (UIColor *)validColor;

@end
