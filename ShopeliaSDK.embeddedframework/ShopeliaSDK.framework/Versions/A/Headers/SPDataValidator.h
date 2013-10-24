//
//  SPDataValidator.h
//  ShopeliaSDK
//
//  Created by Nicolas on 10/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPDataValidator : NSObject

// returns the character set used to validate a date
+ (NSCharacterSet *)validDateCharacterSet;

// returns the character set used to validate a number
+ (NSCharacterSet *)validNumberCharacterSet;

// checks if a string is a valid email
+ (BOOL)stringIsValidEmail:(NSString *)string;

// checks if a string is a valid phone number
+ (BOOL)stringIsValidPhoneNumber:(NSString *)string;

// checks if a string constains valid phone number chars
+ (BOOL)stringContainsValidPhoneNumberCharacters:(NSString *)string;

// checks if a string is a valid number
+ (BOOL)stringContainsValidNumberCharacters:(NSString *)string;

// checks if a string is a valid date (
+ (BOOL)stringContainsValidDateCharacters:(NSString *)string;

// checks if a string passes the luhn algorythm
+ (BOOL)stringPassesLuhnAlgorythm:(NSString *)string;

@end
