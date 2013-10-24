//
//  SPFormButton.h
//  ShopeliaSDK
//
//  Created by Nicolas on 11/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPButton.h"
#import "SPFormFieldValidation.h"

@interface SPFormButton : SPButton <SPFormFieldValidation>

@property (strong, nonatomic) id data;

@end
