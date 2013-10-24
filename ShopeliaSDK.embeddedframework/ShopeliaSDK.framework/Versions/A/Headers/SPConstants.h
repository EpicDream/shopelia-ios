//
//  SPConstants.h
//  ShopeliaSDK
//
//  Created by Nicolas on 03/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#ifndef ShopeliaSDK_Constants_H
#define ShopeliaSDK_Constants_H

#define SPCurrentVersionString SHOPELIA_VERSION_NUMBER
#define SPResourcesBundleFilename @"ShopeliaSDKResources.bundle"
#define SPMainBundleAPIKeyName @"ShopeliaAPIKey"
#define SPStringsFilename @"ShopeliaSDK"
#define SPBundleIdentifierString SHOPELIA_BUNDLE_IDENTIFIER_STRING

#define SPDefaultDeveloperTracker @"shopelia-ios"
#define SPCGUStringURL @"https://www.shopelia.com/cgu"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif