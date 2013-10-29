//
//  SPView.h
//  ShopeliaSDK
//
//  Created by Nicolas on 05/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPViewCustomization.h"
#import "SPVisualFactory.h"
#import "SPViewContentSize.h"

@interface SPView : UIView <SPViewCustomization, SPViewContentSize>

// returns a new instance of the receiver loaded from its nib
+ (instancetype)instanciateFromNib;

// returns a new instance of the receiver loaded from its nib in a particular bundle
+ (instancetype)instanciateFromNibInBundle:(NSBundle *)bundle;

@end
