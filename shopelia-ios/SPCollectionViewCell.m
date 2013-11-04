//
//  SPCollectionViewCell.m
//  shopelia-ios
//
//  Created by Nicolas on 04/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPCollectionViewCell.h"

@implementation SPCollectionViewCell

#pragma mark - Cell

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    for (id subview in self.contentView.subviews)
    {
        if ([subview respondsToSelector:@selector(setHighlighted:)])
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
