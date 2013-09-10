//
//  AppDelegate.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/9/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "SPZBarReaderViewController.h"
#import "SPNavigationController.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) SPZBarReaderViewController *viewController;
@property (strong, nonatomic) UINavigationController *navController;


@end
