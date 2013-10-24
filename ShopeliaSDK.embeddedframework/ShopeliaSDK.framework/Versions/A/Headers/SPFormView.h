//
//  SPFormView.h
//  ShopeliaSDK
//
//  Created by Nicolas on 11/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPFormSectionView.h"
#import "SPViewCustomization.h"
#import "SPFormViewValidation.h"
#import "SPFormTextField.h"

@interface SPFormView : UIView <SPViewCustomization, SPFormViewValidation>

// returns the number of sections
- (NSUInteger)sectionsCount;

// returns all sections
- (NSArray *)allSections; // of SPFormSectionView

// returns the section at the given index
- (SPFormSectionView *)sectionAtIndex:(NSUInteger)index;

@end
