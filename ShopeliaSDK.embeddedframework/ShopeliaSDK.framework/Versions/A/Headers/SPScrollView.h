//
//  SPScrollView.h
//  ShopeliaSDK
//
//  Created by Nicolas on 06/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPViewCustomization.h"
#import "SPViewContentSize.h"

@interface SPScrollView : UIScrollView <SPViewCustomization, SPViewContentSize>

- (UIImageView *)verticalScroller;
- (UIImageView *)horizontalScroller;
- (CGFloat)shopeliaFooterOverheight;

@end
