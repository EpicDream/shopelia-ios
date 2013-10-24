//
//  SPTextField.h
//  ShopeliaSDK
//
//  Created by Nicolas on 09/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPViewCustomization.h"
#import "SPViewTranslation.h"
#import "SPAnalyticsInformation.h"

@interface SPTextField : UITextField <SPViewCustomization, SPViewTranslation, SPAnalyticsInformation>

// returns the external delegate class
- (Class)externalDelegateClass;

@property (assign, nonatomic) NSInteger maximumCharactersCount;
@property (strong, nonatomic) NSCharacterSet *allowedCharacterSet;
@property (weak, nonatomic) id <UITextFieldDelegate> trueDelegate;

@end
