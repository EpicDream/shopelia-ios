//
//  SPDataConvertor.h
//  ShopeliaSDK
//
//  Created by Nicolas on 19/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPDataConvertor : NSObject

// returns an date from the given card expiry date format
+ (NSDate *)dateFromCardExpiryDateString:(NSString *)string;

// returns the ISO country code for the given country name
+ (NSString *)ISOCountryCodeFromCountryName:(NSString *)name;

// returns the country name for the given ISO country code
+ (NSString *)countryNameFromISOCountryCode:(NSString *)code;

// returns a date that points to the last second of the month for the given date
+ (NSDate *)lastMonthSecondOfDate:(NSDate *)date;

// returns a date by adding a precise number of days, months and years
+ (NSDate *)dateByAddingDays:(NSInteger)days months:(NSInteger)months years:(NSInteger)years toDate:(NSDate *)date;

// returns the HTML stripped string of the parameter
+ (NSString *)stringByStrippingHTML:(NSString *)string;

// returns the trimmed parameter string
+ (NSString *)stringByTrimmingString:(NSString *)string;

// returns a string representation of any data
+ (NSString *)stringFromData:(NSData *)data;

// returns a hex string representation of any data
+ (NSString *)hexStringFromData:(NSData *)data;

// returns a rounded decimal number
+ (NSDecimalNumber *)roundedDecimalNumber:(NSDecimalNumber *)decimalNumber roundingMode:(NSRoundingMode)roundingMode scale:(short)scale;

// returns a SHA1 hash from a given string
+ (NSString *)SHA1fromString:(NSString *)string;

@end
