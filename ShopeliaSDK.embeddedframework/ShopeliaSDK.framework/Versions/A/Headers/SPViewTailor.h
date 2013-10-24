//
//  SPViewTailor.h
//  ShopeliaSDK
//
//  Created by Nicolas on 18/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPViewTailor : NSObject

// returns the view content size
+ (CGSize)contentSizeOfView:(UIView *)view;
+ (CGSize)contentSizeOfView:(UIView *)view excludedSubviews:(NSArray *)excludedViews;

// returns a view's hidden subviews
+ (NSArray *)hiddenSubviewsOfView:(UIView *)view;

// sorts views vertically
+ (NSArray *)verticallySortedViews:(NSArray *)views ascending:(BOOL)ascending;

// sorts views horizontally
+ (NSArray *)horizontallySortedViews:(NSArray *)views ascending:(BOOL)ascending;

// resizes a view
+ (void)resizeViewToFitContentSize:(UIView *)view;
+ (void)resizeViewToFitContentSize:(UIView *)view excludedSubviews:(NSArray *)excludedSubviews;
+ (void)resizeViewToFitContentSizeWidth:(UIView *)view;
+ (void)resizeViewToFitContentSizeWidth:(UIView *)view excludedSubviews:(NSArray *)excludedSubviews;
+ (void)resizeViewToFitContentSizeHeight:(UIView *)view;
+ (void)resizeViewToFitContentSizeHeight:(UIView *)view excludedSubviews:(NSArray *)excludedSubviews;

@end
