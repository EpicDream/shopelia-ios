//
//  SPFormFieldValidation.h
//  ShopeliaSDK
//
//  Created by Nicolas on 09/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPFormViewValidation.h"
#import "SPFormSectionView.h"

typedef enum {
    SPFormFieldValidationStateUnvalidated = 0,
    SPFormFieldValidationStateValid,
    SPFormFieldValidationStateInvalid
} SPFormFieldValidationState;

@protocol SPFormFieldValidation <SPFormViewValidation>

@property (weak, nonatomic) SPFormSectionView *section;
@property (assign, nonatomic) SPFormFieldValidationState validationState;

@end
