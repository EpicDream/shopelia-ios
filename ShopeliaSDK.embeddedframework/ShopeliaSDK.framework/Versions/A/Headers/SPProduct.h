//
//  SPProduct.h
//  ShopeliaSDK
//
//  Created by Nicolas on 05/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPModelObject.h"
#import "SPMerchant.h"
#import "SPCurrency.h"
#import "SPProductVersion.h"

@interface SPProduct : SPModelObject

// returns the price
- (NSDecimalNumber *)price;

// returns the price as a formatted string with current locale and product currency
- (NSString *)formattedPrice;

// returns the strikeout price
- (NSDecimalNumber *)strikeoutPrice;

// returns the strikeout price as a formatted string with current locale and product currency
- (NSString *)formattedStrikeoutPrice;

// returns the shipping price
- (NSDecimalNumber *)shippingPrice;

// returns the shipping price as a formatted string with current locale and product currency
- (NSString *)formattedShippingPrice;

// returns the total price (price + shipping price)
- (NSDecimalNumber *)totalPrice;

// returns the total price as a formatted string with current locale and product currency
- (NSString *)formattedTotalPrice;

// returns the expected total price (total price - cash front)
- (NSDecimalNumber *)expectedTotalPrice;

// returns the cashfront value
- (NSDecimalNumber *)cashFrontValue;

// returns the cash front value as a formatted string with current locale and product currency
- (NSString *)formattedCashFrontValue;

// returns all the versions
- (NSSet *)allVersions; // of SPProductVersion

// returns the selected product version
- (SPProductVersion *)selectedVersion;

// returns all the options
- (NSArray *)allOptions; // of NSArray of SPProductOptionValue

// returns the selected product options
- (NSArray *)selectedOptionValues; // of SPProductOptionValue

// returns the product name
- (NSString *)name;

// returns the product description
- (NSString *)definition;

// returns the product image URL
- (NSURL *)imageURL;

// returns the product shipping info
- (NSString *)shippingInfo;

// returns the product availability info
- (NSString *)availabilityInfo;

// changes the current selected version hash given a new option value
- (void)selectProductOptionValue:(SPProductOptionValue *)optionValue forOptionIndex:(NSInteger)optionIndex;

@property (assign, nonatomic) NSUInteger selectedVersionHash;
@property (strong, nonatomic) SPMerchant *merchant;
@property (strong, nonatomic) NSURL *URL;
@property (strong, nonatomic) NSNumber *ID;
@property (strong, nonatomic) SPCurrency *currency;

@end