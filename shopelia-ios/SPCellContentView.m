//
//  SPCellContentView.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/20/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "SPCellContentView.h"
#import "UIColor+Shopelia.h"
#import "UIView+Shopelia.h"

static const CGFloat kCornerRadius = 4;

@implementation SPCellContentView

@synthesize position;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];

    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[UIColor shopeliaBackgroundColor].CGColor);
    CGContextFillRect(context,self.frame);
        
    CGRect bounds = CGRectInset(self.bounds,0.5 / [UIScreen mainScreen].scale + 10,0.5 / [UIScreen mainScreen].scale);
    UIBezierPath *path;
    if (position == CellPositionSingle) {
        path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:kCornerRadius];
    } else if (position == CellPositionTop) {
        bounds.size.height += 1;
        path = [UIBezierPath bezierPathWithRoundedRect:bounds
                                     byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                           cornerRadii:CGSizeMake(kCornerRadius, kCornerRadius)];
    } else if (position == CellPositionBottom) {
        path = [UIBezierPath bezierPathWithRoundedRect:bounds
                                     byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                           cornerRadii:CGSizeMake(kCornerRadius, kCornerRadius)];
    } else {
        bounds.size.height += 1;
        path = [UIBezierPath bezierPathWithRect:bounds];
    }
    
    //[[UIColor clearColor] setFill];
    [path fillWithBlendMode:kCGBlendModeClear alpha:0];
    [[UIColor shopeliaLightGray] setStroke];
    [path stroke];
    
}

@end
