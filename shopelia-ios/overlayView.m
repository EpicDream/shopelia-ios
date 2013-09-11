//
//  overlayView.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/10/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "overlayView.h"
#import "UIColor+Shopelia.h"
#import "UIView+Shopelia.h"

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
    
    //Adding Bottom View
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.Height - (90+44+20), self.Width, 90)];

    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    //Adding Bar code to bottom view
    
    UIImageView *barCode = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar-code.png"]];
    [barCode setFrameOriginWithX:10.0 y:(bottomView.Height - barCode.Height)/2];
    [bottomView addSubview:barCode];
    
    
    //Adding bottom label
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(bottomView.Width/2, 0,bottomView.Width/2, bottomView.Height)];
    
    bottomLabel.font =[UIFont fontWithName:@"Helvetica Neue" size:14.0];
    bottomLabel.text = @"Centrez le code-barre dans la zone ci-dessus";
    bottomLabel.textAlignment = UITextAlignmentCenter;
    bottomLabel.backgroundColor = [UIColor clearColor];
    bottomLabel.textColor = [UIColor shopeliaBlue];
    bottomLabel.lineBreakMode = NSLineBreakByWordWrapping;
    bottomLabel.numberOfLines = 2;
    [bottomView addSubview:bottomLabel];
    
    
    //Adding Top Border
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0, 0, self.Width, 4.0f);
    topBorder.backgroundColor = [UIColor shopeliaBlue].CGColor;
    [bottomView.layer addSublayer:topBorder];
    


    
    //Drawing central rectangle and transparent View
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor);
    CGContextFillRect(context,self.frame);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rectangle = CGRectMake((self.Width - 290)/2,(self.Height - (130+90+44+20))/2 ,290,130);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
    CGContextClearRect(context,rectangle);
    
    
    //Draw centeral blue line
    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor shopeliaLightBlue].CGColor);
    CGContextMoveToPoint(context, rectangle.origin.x, rectangle.origin.y+ rectangle.size.height/2);
    CGContextAddLineToPoint(context, rectangle.origin.x + 290, rectangle.origin.y+ rectangle.size.height/2 );
    CGContextStrokePath(context);
    
    
    //Adding Text on top of central rectangle
    UILabel *centralTextLabel = [[UILabel alloc] initWithFrame:rectangle];
    [centralTextLabel setOrigY:(rectangle.origin.y - rectangle.size.height)/2];
    
    centralTextLabel.font =[UIFont fontWithName:@"Helvetica Neue" size:24.0];
    centralTextLabel.text = @"Profitez des prix exclusifs avec Shopelia";
    centralTextLabel.textAlignment = UITextAlignmentCenter;
    centralTextLabel.backgroundColor = [UIColor clearColor];
    centralTextLabel.textColor = [UIColor whiteColor];
    centralTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    centralTextLabel.numberOfLines = 2;
    [self addSubview:centralTextLabel];
    
    
    
 
}

@end
