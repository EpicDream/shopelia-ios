//
//  SPCurrency.h
//  ShopeliaSDK
//
//  Created by Nicolas on 19/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPCurrency : NSObject

+ (SPCurrency *)euroCurrency;
+ (SPCurrency *)currencyForInternationalCurrencySymbol:(NSString *)symbol;

@property (strong, nonatomic) NSString *internationalCurrencySymbol;
@property (strong, nonatomic) NSString *currencySymbol;

@end
