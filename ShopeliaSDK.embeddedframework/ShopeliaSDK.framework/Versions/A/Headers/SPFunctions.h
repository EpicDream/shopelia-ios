//
//  SPFunctions.h
//  ShopeliaSDK
//
//  Created by Nicolas on 05/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#ifndef ShopeliaSDK_SPFunctions_h
#define ShopeliaSDK_SPFunctions_h

// logs a message to the console with the "Shopelia" prefix
void SPLog(NSString *format, ...);

// returns a localized string
NSString *SPLocalizedString(NSString *key);

// returns the ShopeliaSDKResources bundle
NSBundle *SPResourcesBundle(void);

// returns the API key defined in the user's main application's plist
NSString *SPMainBundleAPIKey(void);

// percent encodes a string
NSString *SPPercentEncodedString(NSString *string);

// flushes all the static variables
void SPFlushStaticVariables(void);

// returns the system caches directory
NSString *SPSystemCachesDirectory(void);

// returns the system library directory
NSString *SPSystemLibraryDirectory(void);

#endif
