//
//  SPFormTextField.h
//  ShopeliaSDK
//
//  Created by Nicolas on 10/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPTextField.h"
#import "SPFormFieldValidation.h"
#import "SPDataValidator.h"

@interface SPFormTextField : SPTextField <SPFormFieldValidation>

// computes the internal text
- (void)computeInternalText;

@property (strong, nonatomic) NSString *internalText;
@property (assign, nonatomic) SPFormFieldValidationState validationState;
@property (assign, nonatomic) BOOL bypassesValidation;
@property (assign, nonatomic) NSUInteger minimumCharactersCount;

@end
