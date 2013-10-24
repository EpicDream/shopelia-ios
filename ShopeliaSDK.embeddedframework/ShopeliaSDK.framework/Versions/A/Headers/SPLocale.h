//
//  SPLocale.h
//  ShopeliaSDK
//
//  Created by Nicolas on 19/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLocale : NSLocale

// returns all available locales
+ (NSArray *)allLocales; // of NSLocales

// returns all usable locales
+ (NSArray *)usableLocales; // of NSLocales

// returns all usable locale identifers
+ (NSArray *)usableLocaleIdentifiers; // of NSString

@end
