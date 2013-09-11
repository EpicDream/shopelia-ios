//
//  overlayView.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/10/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "overlayView.h"
#import "UIColor+Shopelia.h"

@implementation overlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect frame = self.frame;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - (90+44+20), frame.size.width, 90)];

    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    CALayer *topBorder = [CALayer layer];
    
    topBorder.frame = CGRectMake(0, 0, frame.size.width, 4.0f);
    
    topBorder.backgroundColor = [UIColor shopeliaBlue].CGColor;
    
    [bottomView.layer addSublayer:topBorder];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor);
    CGContextFillRect(context,frame);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rectangle = CGRectMake((frame.size.width - 290)/2,(frame.size.height - (130+90+44+20))/2 ,290,130);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
    CGContextClearRect(context,rectangle);
    
 
}

@end
