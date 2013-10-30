//
//  SPViewController.h
//  ShopeliaSDK
//
//  Created by Nicolas on 05/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPOrder.h"
#import "SPFunctions.h"
#import "SPScrollView.h"
#import "SPTableView.h"
#import "SPParams.h"
#import "SPAPIV1Client.h"
#import "SPAPIV2Client.h"
#import "SPLoadingView.h"
#import "SPBarButtonItem.h"
#import "SPViewTailor.h"
#import "SPAnalyticsManager.h"
#import "SPAnalyticsInformation.h"

typedef enum
{
    SPViewControllerPresentationModeNavigation = 0,
    SPViewControllerPresentationModeModal,
    SPViewControllerPresentationModeContained
} SPViewControllerPresentationMode;

@interface SPViewController : UIViewController <SPAnalyticsInformation>

// setups the UI, to reimplement
- (void)setupUI;

// returns the first responder for a given view
+ (UIView *)firstResponderInView:(UIView *)view;

// returns the first view of the given class in the given view hierarchy
+ (id)firstSubviewOfClass:(Class)class inView:(UIView *)rootView;

// transmits internal parameters to a given view controller
- (void)transmitParametersToViewController:(SPViewController *)viewController;

// shows the loading view
- (void)showLoadingView:(BOOL)show;

// validate the view controller
- (void)validateViewController; // to reimplement

// cancels the view controller, automatically called
- (void)cancelViewController;

// returns the container view controller
- (SPViewController *)containerViewController;

// dismisses the receiver with the original presentation animated flag
- (void)dismissWithCompletion:(void (^)(void))completion;

// dismisses Shopelia with the original presentation animated flag
- (void)dismissShopeliaWithCompletion:(void (^)(void))completion;

// customizes the given view
- (void)customizeView:(UIView *)view;

// translates the given view
- (void)translateView:(UIView *)view;

// customizes the given view
+ (void)customizeView:(UIView *)view;

// translates the given view
+ (void)translateView:(UIView *)view;

@property (strong, nonatomic) SPOrder *order;
@property (strong, nonatomic) SPParams *params;

@property (strong, nonatomic) SPScrollView *scrollView;
@property (strong, nonatomic) SPTableView *tableView;
@property (strong, nonatomic) SPLoadingView *loadingView;

@property (assign, nonatomic) BOOL hidesCancelButton;
@property (assign, nonatomic) SPViewControllerPresentationMode presentationMode;

@end
