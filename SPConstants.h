//
//  Constants.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/13/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *const BASE_URL;
extern NSString *const API_URL;


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO( v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface Constants : NSObject


@end
