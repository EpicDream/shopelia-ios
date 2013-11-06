//
//  SPCardButton.m
//  shopelia-ios
//
//  Created by Nicolas on 30/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPCardButton.h"

@implementation SPCardButton

#pragma mark - Customize

- (void)customize
{
    [super customize];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    UIImage *backgroundImage = [[UIImage imageNamed:@"card_background_inactive.png"] resizableImageWithCapInsets:insets];
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    backgroundImage = [[UIImage imageNamed:@"card_background_inactive.png"] resizableImageWithCapInsets:insets];
    [self setBackgroundImage:backgroundImage forState:UIControlStateHighlighted];
}

@end
