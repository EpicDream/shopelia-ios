//
//  SPContainerViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPContainerViewController.h"
#import "SPAlgoliaSearchViewController.h"
#import "SPProductSearchViewController.h"
#import "SPShopeliaManager.h"
#import "SPGeorgeConversationViewController.h"
#import "SPPushNotificationsPermissionViewController.h"
#import "SPPushNotificationsPreferencesManager.h"

@interface SPContainerViewController () <SPAlgoliaSearchViewControllerDelegate, SPGeorgeConversationViewControllerDelegate, SPPushNotificationsPermissionViewControllerDelegate>
@property (strong, nonatomic) SPAlgoliaSearchViewController *algoliaSearchViewController;
@property (strong, nonatomic) SPButton *georgeButton;
@end

@implementation SPContainerViewController

#pragma mark - Lazy instanciation

- (SPAlgoliaSearchViewController *)algoliaSearchViewController
{
    if (!_algoliaSearchViewController)
    {
        _algoliaSearchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SPAlgoliaSearchViewController"];
    }
    return _algoliaSearchViewController;
}

- (SPWaitingMessageView *)waitingMessageView
{
    if (!_waitingMessageView)
    {
        _waitingMessageView = [SPWaitingMessageView instanciateFromNibInBundle:[NSBundle mainBundle]];
    }
    return _waitingMessageView;
}

- (SPErrorMessageView *)errorMessageView
{
    if (!_errorMessageView)
    {
        _errorMessageView = [SPErrorMessageView instanciateFromNibInBundle:[NSBundle mainBundle]];
    }
    return _errorMessageView;
}

- (SPButton *)georgeButton
{
    if (!_georgeButton)
    {
        UIImage *image = [UIImage imageNamed:@"btn_georges_normal.png"];
        _georgeButton = [[SPButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [_georgeButton setImage:image forState:UIControlStateNormal];
        [_georgeButton setImage:[UIImage imageNamed:@"btn_georges_hover.png"] forState:UIControlStateHighlighted];
        [_georgeButton addTarget:self action:@selector(georgeButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _georgeButton;
}

#pragma mark - Actions

- (void)georgeButtonTouched:(SPButton *)sender
{
    // if push notifications were already asked
    if ([[SPPushNotificationsPreferencesManager sharedInstance] userAlreadyGrantedPushNotificationsPermission])
    {
        // show george conversation
        [self showGeorgeConversationViewController];
    }
    else
    {
        // show push notifications permissions
        SPNavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"SPPushNotificationsPermissionNavigationController"];
        SPPushNotificationsPermissionViewController *pushViewController = (SPPushNotificationsPermissionViewController *)navigationController.topViewController;
        pushViewController.delegate = self;
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

- (void)showGeorgeConversationViewController
{
    SPNavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"SPGeorgeConversationNavigationController"];
    SPGeorgeConversationViewController *georgeViewController = (SPGeorgeConversationViewController *)navigationController.topViewController;
    georgeViewController.delegate = self;
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - SPPushNotificationsPermissionViewController delegate

- (void)pushNotificationsPermissionViewControllerUserDidAcceptRemoteNotifications:(SPPushNotificationsPermissionViewController *)viewController
{
    // dissmiss vc
    [viewController dismissViewControllerAnimated:YES completion:^{
        // show george conversation
        [self showGeorgeConversationViewController];
    }];
}

- (void)pushNotificationsPermissionViewControllerUserDidRefuseRemoteNotifications:(SPPushNotificationsPermissionViewController *)viewController
{
    // dissmiss vc
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SPAlgoliaSearchViewController delegate

- (void)algoliaSearchViewController:(SPAlgoliaSearchViewController *)vc didSelectSearchResult:(SPAlgoliaSearchResult *)searchResult
{
    if (searchResult.barcode)
    {
        // fetch product
        SPProductSearchViewController *productSearchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SPProductSearchViewController"];
        productSearchViewController.barcode = searchResult.barcode;
        productSearchViewController.fromScanner = NO;
        [self.navigationController pushViewController:productSearchViewController animated:YES];
    }
    else
    {
        [SPShopeliaManager showShopeliaSDKForURL:searchResult.product.URL fromViewController:self];
    }
}

#pragma mark - SPGeorgeConversationViewController delegate

- (void)georgeConversationViewControllerDidEndConversation:(SPGeorgeConversationViewController *)vc
{
    // dissmiss vc
    [vc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[SPViewController firstResponderInView:self.view] resignFirstResponder];
}

#pragma mark - Interface

- (void)setupUI
{
    [super setupUI];
    
    if (self.showsAlgoliaSearch)
    {
        // add Algolia search view controller
        [self addChildViewController:self.algoliaSearchViewController];
        [self.view addSubview:self.algoliaSearchViewController.view];
        self.algoliaSearchViewController.delegate = self;
    }
    
    if (self.showsGeorge)
    {
        // add George button in view
        [self.view addSubview:self.georgeButton];
    }
}

- (void)setupUIForWaitingMessageView
{
    [self.errorMessageView removeFromSuperview];
    [self.view insertSubview:self.waitingMessageView atIndex:self.view.subviews.count];
}

- (void)setupUIForErrorMessageView
{
    [self.waitingMessageView removeFromSuperview];
    [self.view insertSubview:self.errorMessageView atIndex:self.view.subviews.count];
}

- (void)setupUIForContentView
{
    [self.errorMessageView removeFromSuperview];
    [self.waitingMessageView removeFromSuperview];
}

- (CGFloat)georgeButtonOverHeight
{
    if (self.showsGeorge)
        return [self.georgeButton imageForState:UIControlStateNormal].size.height + 10.0f;
    return 0.0f;
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (self.showsAlgoliaSearch)
    {
        // resize algolia search view
        self.algoliaSearchViewController.view.frame = self.view.bounds;
    }
    
    if (self.showsGeorge)
    {
        // place george button
        self.georgeButton.frame = CGRectMake((self.view.frame.size.width - self.georgeButton.frame.size.width) / 2.0f,
                                              self.view.frame.size.height - self.georgeButton.frame.size.height - 10.0f,
                                              self.georgeButton.frame.size.width,
                                              self.georgeButton.frame.size.height);
    }
    
    CGFloat height = 0.0f;
    
    // resize waiting view
    height = [self.waitingMessageView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.waitingMessageView.frame = CGRectMake(10.0f,
                                               (self.view.bounds.size.height - height) / 2.0f,
                                               self.view.bounds.size.width - 20.0f,
                                               height);
    
    // resize error message view
    height = [self.errorMessageView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.errorMessageView.frame = CGRectMake(10.0f,
                                             (self.view.bounds.size.height - height) / 2.0f,
                                             self.view.bounds.size.width - 20.0f,
                                             height);
}

#pragma mark - View lifecyle

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [[SPViewController firstResponderInView:self.view] resignFirstResponder];
    [[SPViewController firstEditingView:self.view] resignFirstResponder];
}

@end
