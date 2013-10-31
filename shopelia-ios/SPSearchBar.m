//
//  SPSearchBar.m
//  shopelia-ios
//
//  Created by Nicolas on 24/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPSearchBar.h"

@implementation SPSearchBar

#pragma mark - Customization

- (void)customize
{
    // background image
    self.backgroundImage = [[UIImage alloc] init];
    
    // field background image
    UIImage *backgroundImage = [[UIImage imageNamed:@"card_background_inactive.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
    [self setSearchFieldBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    // search image
    [self setImage:[UIImage imageNamed:@"search_icon.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    // offset
    [self setSearchTextPositionAdjustment:UIOffsetMake(5, 0)];
    [self setSearchFieldBackgroundPositionAdjustment:UIOffsetMake(0, 0)];
    [self setPositionAdjustment:UIOffsetMake(5, 0) forSearchBarIcon:UISearchBarIconSearch];
    [self setPositionAdjustment:UIOffsetMake(-5, 0) forSearchBarIcon:UISearchBarIconClear];
    
    // bar style
    self.barStyle = UISearchBarStyleDefault;
    
    // translucent
    self.translucent = YES;
    
    // background color
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UITextField *control = [SPViewController firstSubviewOfClass:[UITextField class] inView:self];
    control.frame = CGRectMake(0, 2, self.bounds.size.width, self.bounds.size.height - 4);
    control.font = [UIFont fontWithName:[SPVisualFactory lightFontName] size:14.0f];
    control.textColor = [SPVisualFactory normalTextColor];
}

@end
