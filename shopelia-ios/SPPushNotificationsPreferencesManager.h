//
//  SPPushNotificationsPreferencesManager.h
//  shopelia-ios
//
//  Created by Nicolas on 13/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <ShopeliaSDK/ShopeliaSDK.h>

@interface SPPushNotificationsPreferencesManager : SPPreferencesManager

- (BOOL)userEnabledRequiredRemoteNotificationType;
- (void)registerForRemoteNotifications;

- (void)markPushNotificationsAsGranted;
- (BOOL)userAlreadyGrantedPushNotificationsPermission;

- (void)setDeviceToken:(NSData *)token;
- (NSData *)deviceToken;

@end
