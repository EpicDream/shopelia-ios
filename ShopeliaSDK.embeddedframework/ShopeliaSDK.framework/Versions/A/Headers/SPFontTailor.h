//
//  SPFontTailor.h
//  ShopeliaSDK
//
//  Created by Nicolas on 26/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPFontTailor : NSObject

// returns the expected height of a font
+ (CGSize)sizeForText:(NSString *)text width:(CGFloat)width font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
