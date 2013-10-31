//
//  SPCardImageView.m
//  shopelia-ios
//
//  Created by Nicolas on 30/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPCardImageView.h"

@implementation SPCardImageView

#pragma mark - Lifecycle

- (void)initialize
{
    UIEdgeInsets insets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    UIImage *backgroundImage = [[UIImage imageNamed:@"card_background_inactive.png"] resizableImageWithCapInsets:insets];
    [self setImage:backgroundImage];
    backgroundImage = [[UIImage imageNamed:@"card_background_active.png"] resizableImageWithCapInsets:insets];
    [self setHighlightedImage:backgroundImage];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialize];
}

@end
