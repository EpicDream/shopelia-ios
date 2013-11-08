//
//  SPProductSummaryViewController.h
//  ShopeliaSDK
//
//  Created by Nicolas on 03/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPViewController.h"
#import "SPViewContentSize.h"

@interface SPProductSummaryViewController : SPViewController

// sets the spinner state
- (void)setSpinning:(BOOL)spinning;

@property (strong, nonatomic) SPProduct *product;

@end
