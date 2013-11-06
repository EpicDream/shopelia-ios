//
//  SPJSONFactory.h
//  ShopeliaSDK
//
//  Created by Nicolas on 29/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPJSONFactory : NSObject

// returns the string value of a JSON object
+ (NSString *)stringValueForJSONObject:(id)object;

// returns the number value of a JSON object
+ (NSNumber *)numberValueForJSONObject:(id)object;

// returns the decimal number value of a JSON object
+ (NSDecimalNumber *)decimalNumberValueForJSONObject:(id)object;

// returns the URL value of a JSON object
+ (NSURL *)URLValueForJSONObject:(id)object;

// returns the bool value of a JSON object
+ (BOOL)boolValueForJSONObject:(id)object;

// returns a NSData version of the JSON object
+ (NSData *)dataFromJSONObject:(id)object;

// returns a JSON object from NSData
+ (id)JSONObjectFromData:(NSData *)data;

@end
