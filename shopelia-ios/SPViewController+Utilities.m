//
//  SPViewController+Utilities.m
//  shopelia-ios
//
//  Created by Nicolas on 07/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPViewController+Utilities.h"

@implementation SPViewController (Utilities)

+ (UIView *)firstEditingView:(UIView *)view
{
    if ([view respondsToSelector:@selector(isEditing)])
    {
        BOOL editing = [((id)view) isEditing];
        if (editing)
            return view;
    }
    
    for (UIView *subview in view.subviews)
    {
        UIView *editingView = [self firstEditingView:subview];
        if (editingView)
            return editingView;
    }
    
    return nil;
}

@end
