//
//  SPLayoutView.h
//  ShopeliaSDK
//
//  Created by Nicolas on 18/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPView.h"
#import "SPViewTailor.h"
#import "SPViewContentSize.h"

@interface SPLayoutView : SPView <SPViewContentSize>

// returns the used layout subviews
- (NSArray *)usedLayoutSubviews;

@property (assign, nonatomic) UIEdgeInsets layoutPadding;
@property (assign, nonatomic) CGFloat layoutSpacing;
@property (assign, nonatomic) BOOL invertsLayout;
@property (assign, nonatomic) BOOL considersHiddenViews;
@property (strong, nonatomic) NSArray *excludedLayoutSubviews;

@end
