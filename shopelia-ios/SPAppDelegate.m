//
//  SPAppDelegate.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/9/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "SPAppDelegate.h"
#import "TestFlight.h"
#import "SPPushNotificationsPreferencesManager.h"
#import "SPDevicesAPIClient.h"
#import "SPChatAPIClient.h"
#import "SPChatConversationViewController.h"
#import "SPContainerViewController.h"
#import "SPApplicationPreferencesManager.h"

@implementation SPAppDelegate

#pragma mark - Application

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    // launch TestFight
//    [TestFlight setOptions:@{TFOptionLogToConsole : @NO, TFOptionLogToSTDERR : @NO, TFOptionLogOnCheckpoint : @NO}];
//    [TestFlight takeOff:SPTestFlightApplicationToken];

    // launch Crashlytics
    [Crashlytics startWithAPIKey:SPCrashlyticsAPIKey];
    
    // renew push notifications token
    if ([[SPPushNotificationsPreferencesManager sharedInstance] userAlreadyGrantedPushNotificationsPermission])
        [[SPPushNotificationsPreferencesManager sharedInstance] registerForRemoteNotifications];
    
    // increment launch count
    [[SPApplicationPreferencesManager sharedInstance] incrementLaunchCount];
    
    // handle push notification
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey])
        [self performSelector:@selector(showChatConversationAfterDelay) withObject:nil afterDelay:1.0f];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // handle push notification
    [[SPChatAPIClient sharedInstance] fetchNewMessages];
    
    // show chat conversation
    [SPChatConversationViewController showChatConversation:NO];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // handle new device token
    [[SPDevicesAPIClient sharedInstance] handleNewDeviceToken:deviceToken];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // fetch new message
    [[SPChatAPIClient sharedInstance] fetchNewMessages];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Chat conversation

- (void)showChatConversationAfterDelay
{
    // show chat conversation
    [SPChatConversationViewController showChatConversation:YES];
}

@end
