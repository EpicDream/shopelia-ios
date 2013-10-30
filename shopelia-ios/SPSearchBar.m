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
    self.backgroundImage = [SPVisualFactory cachedImageNamed:@"shopelia_topbar_background.png"];
    
    // bar style
    self.barStyle = UISearchBarStyleDefault;
    
    // translucent
    self.translucent = NO;
    
    // background color
    self.backgroundColor = [SPVisualFactory navigationBarBackgroundColor];
    
    self.tintColor = [SPVisualFactory navigationBarBackgroundColor];
}

@end
