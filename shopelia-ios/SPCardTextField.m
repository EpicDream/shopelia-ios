//
//  SPCardTextField.m
//  shopelia-ios
//
//  Created by Nicolas on 15/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPCardTextField.h"

@implementation SPCardTextField

- (void)updateBackgroundImage
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(6.0f, 6.0f, 6.0f, 6.0f);
    UIImage *backgroundImage = [[UIImage imageNamed:@"card_background_inactive.png"] resizableImageWithCapInsets:edgeInsets];
    [self setBackground:backgroundImage];
}

@end
