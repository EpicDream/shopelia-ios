//
//  SPDataFormatter.h
//  ShopeliaSDK
//
//  Created by Nicolas on 17/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPCurrency.h"

@interface SPDataFormatter : NSObject

// returns the format used to format a card expiry date
+ (NSString *)cardExpiryDateFormat;

// returns a string that represents a number formatted as a price
+ (NSString *)priceStringFromNumber:(NSNumber *)number currency:(SPCurrency *)currency;

// returns a string that represents a secured card number (with XX)
+ (NSString *)securedCardNumberStringFromCardNumber:(NSString *)number;

@end
