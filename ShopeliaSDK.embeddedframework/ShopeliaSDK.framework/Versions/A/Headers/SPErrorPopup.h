//
//  SPErrorPopup.h
//  ShopeliaSDK
//
//  Created by Nicolas on 25/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPView.h"

@interface SPErrorPopup : SPView

// pops an error from a view
- (void)popFromView:(UIView *)view superview:(UIView *)superview text:(NSString *)text;

@end
