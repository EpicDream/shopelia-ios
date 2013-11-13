//
//  SPPushNotificationsPermissionViewController.h
//  shopelia-ios
//
//  Created by Nicolas on 12/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPContainerViewController.h"

@class SPPushNotificationsPermissionViewController;

@protocol SPPushNotificationsPermissionViewControllerDelegate <NSObject>

- (void)pushNotificationsPermissionViewControllerUserDidAcceptRemoteNotifications:(SPPushNotificationsPermissionViewController *)viewController;
- (void)pushNotificationsPermissionViewControllerUserDidRefuseRemoteNotifications:(SPPushNotificationsPermissionViewController *)viewController;

@end

@interface SPPushNotificationsPermissionViewController : SPContainerViewController

@property (weak, nonatomic) id <SPPushNotificationsPermissionViewControllerDelegate> delegate;

@end
