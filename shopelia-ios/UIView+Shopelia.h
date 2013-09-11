//
//  UIView+Shopelia.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/11/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shopelia)
-(void)offsetFrameWithDx:(CGFloat) dx dy:(CGFloat)dy;
-(void)setFrameOriginWithX:(CGFloat)x y:(CGFloat)y;
-(void)setFrameSizeWithW:(CGFloat)w h:(CGFloat)h;
-(CGFloat)Width;
-(CGFloat)Height;
-(CGFloat)OrigX;
-(CGFloat)OrigY;
-(void)setWidth:(CGFloat)width;
-(void)setHeight:(CGFloat)height;
-(void)setOrigX:(CGFloat)x;
-(void)setOrigY:(CGFloat)y;

@end
