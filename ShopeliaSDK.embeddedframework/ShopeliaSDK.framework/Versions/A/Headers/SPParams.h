//
//  SPParams.h
//  ShopeliaSDK
//
//  Created by Nicolas on 18/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPNavigationController.h"
#import <UIKit/UIKit.h>

@interface SPParams : NSObject

@property (strong, nonatomic) NSString *tracker;
@property (weak, nonatomic) SPNavigationController *mainNavigationController;
@property (weak, nonatomic) UIViewController *userPresentingViewController;
@property (assign, nonatomic) BOOL userPresentationWasAnimated;

@end
