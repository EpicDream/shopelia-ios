//
//  SPFormSectionView.h
//  ShopeliaSDK
//
//  Created by Nicolas on 11/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPFormSectionHeaderView.h"
#import "SPViewCustomization.h"
#import "SPFormViewValidation.h"

@interface SPFormSectionView : UIView <SPViewCustomization, SPFormViewValidation>

// returns the association header view
- (SPFormSectionHeaderView *)headerView;

// returns the number of fields
- (NSUInteger)fieldsCount;

// returns all fields
- (NSArray *)allFields; // of id

// returns the field at the given index
- (id)fieldAtIndex:(NSUInteger)index;

@end
