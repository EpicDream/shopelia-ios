//
//  SPFormSectionHeaderView.h
//  ShopeliaSDK
//
//  Created by Nicolas on 11/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPViewCustomization.h"

@interface SPFormSectionHeaderView : UIView <SPViewCustomization>

@property (assign, nonatomic, getter = isValid) BOOL valid;

@end
