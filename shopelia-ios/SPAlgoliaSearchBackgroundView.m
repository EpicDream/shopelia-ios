//
//  SPAlgoliaSearchBackgroundView.m
//  shopelia-ios
//
//  Created by Nicolas on 30/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAlgoliaSearchBackgroundView.h"

@implementation SPAlgoliaSearchBackgroundView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == self)
        return nil;
    return view;
}

@end
