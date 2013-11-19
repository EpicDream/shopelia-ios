//
//  SPApplicationPreferencesManager.h
//  shopelia-ios
//
//  Created by Nicolas on 15/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <ShopeliaSDK/ShopeliaSDK.h>

@interface SPApplicationPreferencesManager : SPPreferencesManager

- (unsigned long long)launchCount;
- (void)incrementLaunchCount;

@end
