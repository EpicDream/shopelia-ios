//
//  SPLargeImportantButton.m
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPLargeImportantButton.h"

@implementation SPLargeImportantButton

#pragma mark - Customization

- (void)customize
{
    [super customize];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    UIImage *image = [[UIImage imageNamed:@"error_button_background_normal.png"] resizableImageWithCapInsets:insets];
    [self setBackgroundImage:image forState:UIControlStateNormal];
    image = [[UIImage imageNamed:@"error_button_background_focus.png"] resizableImageWithCapInsets:insets];
    [self setBackgroundImage:image forState:UIControlStateHighlighted];
}

@end
