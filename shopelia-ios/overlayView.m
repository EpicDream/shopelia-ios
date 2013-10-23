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

@interface overlayView ()
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UILabel *centralTextLabel;
@end

@implementation overlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        
        
        //Adding Bottom View
        self.bottomView = [[UIView alloc] init];
        self.bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bottomView];

        
        //Adding Bar code to bottom view
        UIImageView *barCode = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar-code.png"]];
        [barCode setFrameOriginWithX:10.0 y:(90 - barCode.Height)/2];
        [self.bottomView addSubview:barCode];
        
        
        //Adding bottom label
        UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(320 / 2 - 20.0f, 0, 320.0f / 2, 90.0f)];
        bottomLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0];
        bottomLabel.text = @"Centrez le code-barre dans la zone ci-dessus";
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
        bottomLabel.textAlignment = UITextAlignmentCenter;
#else
        bottomLabel.textAlignment = NSTextAlignmentCenter;
#endif
        bottomLabel.backgroundColor = [UIColor clearColor];
        bottomLabel.textColor = [UIColor shopeliaBlue];
        bottomLabel.lineBreakMode = NSLineBreakByWordWrapping;
        bottomLabel.numberOfLines = 2;
        [self.bottomView addSubview:bottomLabel];
        
        //Adding Top Border
        UIView *topBorder = [[UIView alloc] init];
        topBorder.frame = CGRectMake(0, 0, 320.0f, 4.0f);
        topBorder.backgroundColor = [UIColor shopeliaBlue];
        [self.bottomView addSubview:topBorder];
        
        
        //Adding Text on top of central rectangle
        self.centralTextLabel = [[UILabel alloc] init];
        self.centralTextLabel.font =[UIFont fontWithName:@"Helvetica Neue" size:22.0];
        self.centralTextLabel.text = @"La façon la plus simple d’acheter avec votre mobile !";
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
        centralTextLabel.textAlignment = UITextAlignmentCenter;
#else
        self.centralTextLabel.textAlignment = NSTextAlignmentCenter;
#endif
        self.centralTextLabel.backgroundColor = [UIColor clearColor];
        self.centralTextLabel.textColor = [UIColor whiteColor];
        self.centralTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.centralTextLabel.numberOfLines = 2;
        [self addSubview:self.centralTextLabel];
    }
    
    return self;
}

- (CGSize)scanRectangleSize
{
    return CGSizeMake(290.0f, 130.0f);
}

- (void)layoutSubviews
{
    self.bottomView.frame = CGRectMake(0, self.Height - 90, self.Width, 90);
    self.centralTextLabel.frame = CGRectMake(10, (((self.Height - 90 - self.scanRectangleSize.height) / 2.0f) - 55) / 2, self.Width - 20, 55);
}

- (void)drawRect:(CGRect)rect
{
    //Drawing central rectangle and transparent View
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor);
    CGContextFillRect(context, self.bounds);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rectangle = CGRectMake((self.Width - self.scanRectangleSize.width) / 2,
                                  (self.Height - (self.scanRectangleSize.height) - 90) / 2,
                                  self.scanRectangleSize.width,
                                  self.scanRectangleSize.height);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
    CGContextClearRect(context, rectangle);

    //Draw centeral blue line
    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor shopeliaLightBlue].CGColor);
    CGContextMoveToPoint(context, rectangle.origin.x, rectangle.origin.y+ rectangle.size.height/2);
    CGContextAddLineToPoint(context, rectangle.origin.x + 290, rectangle.origin.y+ rectangle.size.height/2 );
    CGContextStrokePath(context);
}


@end
