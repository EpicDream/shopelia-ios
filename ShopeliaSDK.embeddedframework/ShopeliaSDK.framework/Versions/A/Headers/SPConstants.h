//
//  SPConstants.h
//  ShopeliaSDK
//
//  Created by Nicolas on 03/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#ifndef ShopeliaSDK_Constants_H
#define ShopeliaSDK_Constants_H

#define SPBundleIdentifierString SHOPELIA_BUNDLE_IDENTIFIER_STRING
#define SPBundleVersionString SHOPELIA_VERSION_STRING
#define SPBundleBuildNumberString SHOPELIA_BUILD_NUMBER

#define SPResourcesBundleFilename @"ShopeliaSDKResources.bundle"
#define SPMainBundleAPIKeyName @"ShopeliaAPIKey"
#define SPStringsFilename @"ShopeliaSDK"

#define SPDefaultDeveloperTracker @"shopelia-ios"
#define SPCGUStringURL @"https://www.shopelia.com/cgu"

#define SP_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SP_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SP_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SP_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SP_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif