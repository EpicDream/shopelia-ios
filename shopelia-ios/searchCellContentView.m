
//
//  searchCellContentView.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 10/18/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "searchCellContentView.h"
#import "UIColor+Shopelia.h"
#import "UIView+Shopelia.h"

static const CGFloat kCornerRadius = 2;


@implementation searchCellContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        // Initialization code
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[UIColor shopeliaBackgroundColor].CGColor);
    CGContextFillRect(context,self.frame);
    CGRect content = self.bounds;
    content.size.height = 77;
    content.origin.y += 5;
    
    CGRect bounds = CGRectInset(content,0.5 / [UIScreen mainScreen].scale + 10,0.5 / [UIScreen mainScreen].scale);
    UIBezierPath *path;
    path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:kCornerRadius];
    
    //[[UIColor clearColor] setFill];
    [path fillWithBlendMode:kCGBlendModeClear alpha:0];
    [[UIColor shopeliaLightGray] setStroke];
    [path stroke];
    
}

@end
