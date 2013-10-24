//
//  SPLabel.h
//  ShopeliaSDK
//
//  Created by Nicolas on 05/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPViewCustomization.h"
#import "SPViewTranslation.h"
#import "SPVisualFactory.h"
#import "SPViewLayoutAutoresize.h"

@interface SPLabel : UILabel <SPViewCustomization, SPViewTranslation, SPViewLayoutAutoresize>

// returns the tailored rendered size of the label
- (CGSize)tailoredSizeForWidth:(CGFloat)width;

@property (assign, nonatomic) BOOL convertsTags;
@property (assign, nonatomic) BOOL strikesThrough;


@end
