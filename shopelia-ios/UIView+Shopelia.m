//
//  UIView+Shopelia.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/11/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "UIView+Shopelia.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Shopelia)
-(void)offsetFrameWithDx:(CGFloat) dx dy:(CGFloat)dy
{
    self.frame = CGRectOffset(self.frame, dx, dy);
}
-(void)setFrameOriginWithX:(CGFloat)x y:(CGFloat)y
{
    self.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
}
-(void)setFrameSizeWithW:(CGFloat)w h:(CGFloat)h
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, w,h);
}

-(CGFloat)Width
{
    return self.frame.size.width;
}
-(CGFloat)Height
{
    return self.frame.size.height;
}
-(CGFloat)OrigX
{
    return self.frame.origin.x;
}
-(CGFloat)OrigY
{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width
{
    [self setFrameSizeWithW:width h:self.Height];
}
-(void)setHeight:(CGFloat)height
{
    [self setFrameSizeWithW:self.Width h:height];
}
-(void)setOrigX:(CGFloat)x
{
    [self setFrameOriginWithX:x y:self.OrigY];
}
-(void)setOrigY:(CGFloat)y
{
    [self setFrameOriginWithX:self.OrigX y:y];
}

@end
