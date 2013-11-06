//
//  SPTableViewCell.m
//  shopelia-ios
//
//  Created by Nicolas on 25/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPTableViewCell.h"

@implementation SPTableViewCell

#pragma mark - Cell

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    for (id subview in self.contentView.subviews)
    {
        if ([subview respondsToSelector:@selector(setHighlighted:animated:)])
            [subview setHighlighted:highlighted animated:animated];
        else if ([subview respondsToSelector:@selector(setHighlighted:)])
            [subview setHighlighted:highlighted];
    }
}

#pragma mark - Customization

- (void)customize
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

#pragma mark - Translation

- (void)translate
{
    
}

#pragma mark - Lifecycle

- (void)awakeFromNib
{
    [SPViewController customizeView:self];
    [SPViewController translateView:self];
}

@end
