//
//  SPBarcodeOverlayView.m
//  shopelia-ios
//
//  Created by Nicolas on 24/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPBarcodeOverlayView.h"

@interface SPBarcodeOverlayView ()
@property (strong, nonatomic) UILabel *centralTextLabel;
@end

@implementation SPBarcodeOverlayView

- (CGSize)scanSize
{
    return CGSizeMake(290.0f, 130.0f);
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    // central text
    self.centralTextLabel = [[UILabel alloc] init];
    self.centralTextLabel.text = NSLocalizedString(@"TheEasiestWayToBuyFromYourMobile", nil);
    [self.centralTextLabel setTextColor:[UIColor whiteColor]];
    [self.centralTextLabel setTextAlignment:NSTextAlignmentCenter];
    [self.centralTextLabel setNumberOfLines:0];
    [self.centralTextLabel setFont:[UIFont fontWithName:[SPVisualFactory regularFontName] size:20.0f]];
    [self.centralTextLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.centralTextLabel];
}

- (void)layoutSubviews
{
    self.centralTextLabel.frame = CGRectMake(15.0f,
                                             0,
                                             self.bounds.size.width - 30.0f,
                                             ((self.bounds.size.height - self.scanSize.height) / 2.0f));
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // draw central rectangle and transparent View
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor);
    CGContextFillRect(context, self.bounds);
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rectangle = CGRectMake((self.bounds.size.width - self.scanSize.width) / 2.0,
                                  (self.bounds.size.height - self.scanSize.height) / 2.0,
                                  self.scanSize.width,
                                  self.scanSize.height);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
    CGContextClearRect(context, rectangle);
    
    // draw centeral blue line
    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0f green:198.0 / 255.0f blue:1.0 alpha:1.0].CGColor);
    CGContextMoveToPoint(context, rectangle.origin.x, rectangle.origin.y+ rectangle.size.height/2);
    CGContextAddLineToPoint(context, rectangle.origin.x + 290, rectangle.origin.y+ rectangle.size.height/2 );
    CGContextStrokePath(context);
}

@end
