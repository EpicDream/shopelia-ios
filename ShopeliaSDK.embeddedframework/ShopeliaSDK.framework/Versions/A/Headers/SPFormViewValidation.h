//
//  SPFormValidation.h
//  ShopeliaSDK
//
//  Created by Nicolas on 17/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SPFormValidationModeHard = 0,
    SPFormValidationModeSoft
} SPFormValidationMode;

typedef enum {
    SPFormFieldValidationErrorEmpty = 0,
    SPFormFieldValidationErrorInvalidCharacters,
    SPFormFieldValidationErrorMinimumCharactersCountNotReached,
    SPFormFieldValidationErrorMaximumCharactersCountExceeded,
    SPFormFieldValidationErrorInvalidEmail,
    SPFormFieldValidationErrorInvalidPhoneNumber,
    SPFormFieldValidationErrorInvalidCountry,
    SPFormFieldValidationErrorInvalidCardNumber,
    SPFormFieldValidationErrorIncorrectCardNumber,
    SPFormFieldValidationErrorInvalidCardType,
    SPFormFieldValidationErrorInvalidCardExpiryDate,
    SPFormFieldValidationErrorCardExpired,
    SPFormFieldValidationErrorCardExpiryDateTooFar
} SPFormFieldValidationError;

@protocol SPFormViewValidation <NSObject>

- (BOOL)validate:(SPFormValidationMode)mode;
- (NSArray *)validationErrors;

@end
