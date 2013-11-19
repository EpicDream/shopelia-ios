//
//  SPPushNotificationsPreferencesManager.m
//  shopelia-ios
//
//  Created by Nicolas on 13/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPPushNotificationsPreferencesManager.h"

#define SPPushNotificationsGrantedPermissionKey @"UserAlreadyGrantedPermission"
#define SPPushNotificationsDeviceTokenKey @"DeviceToken"

@implementation SPPushNotificationsPreferencesManager

#pragma mark - Preferences

- (NSString *)preferencesFilename
{
    return @"push_notifications";
}

- (UIRemoteNotificationType)usedRemoteNofiticationType
{
    return UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
}

- (BOOL)userEnabledRequiredRemoteNotificationType
{
    UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    return ((type & UIRemoteNotificationTypeAlert) == UIRemoteNotificationTypeAlert);
}

- (BOOL)userAlreadyGrantedPushNotificationsPermission
{
    return [[self objectForKey:SPPushNotificationsGrantedPermissionKey] boolValue];
}

- (void)markPushNotificationsAsGranted
{
    [self setObject:[NSNumber numberWithBool:YES] forKey:SPPushNotificationsGrantedPermissionKey];
}

- (NSData *)deviceToken
{
    return [self objectForKey:SPPushNotificationsDeviceTokenKey];
}

- (void)setDeviceToken:(NSData *)token
{
    [self setObject:token forKey:SPPushNotificationsDeviceTokenKey];
}

- (void)registerForRemoteNotifications
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:[self usedRemoteNofiticationType]];
}

@end
