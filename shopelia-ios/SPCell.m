//
//  SPCell.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/19/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "SPCell.h"
#import "UIColor+Shopelia.h"
#import "UIView+Shopelia.h"

static const CGFloat kCornerRadius = 4;

@implementation SPCell

@synthesize position;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        //self.position = 2;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
    [self setOrigX: 10.0];
    [self setWidth:310.0];
    //[self setHeight:60.0];
    
    CGRect bounds = CGRectInset(self.bounds,0.5 / [UIScreen mainScreen].scale,0.5 / [UIScreen mainScreen].scale);
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
    
    [[UIColor whiteColor] setFill];
    [[UIColor shopeliaLightGray] setStroke];
    [path fill];
    [path stroke];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
