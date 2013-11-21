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
#import "SPChatConversationViewController.h"

@interface SPContainerViewController () <SPAlgoliaSearchViewControllerDelegate, SPChatConversationViewControllerDelegate>
@property (strong, nonatomic) SPAlgoliaSearchViewController *algoliaSearchViewController;
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

- (SPChatButton *)chatButton
{
    if (!_chatButton)
    {
        _chatButton = [[SPChatButton alloc] initWithFrame:CGRectMake(0, 0, 75.0f, 75.0f)];
        [_chatButton addTarget:self action:@selector(chatButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chatButton;
}

- (SPLabel *)notificationLabel
{
    if (!_notificationLabel)
    {
        _notificationLabel = [[SPSmallLabel alloc] init];
        _notificationLabel.textAlignment = NSTextAlignmentCenter;
        [SPViewController customizeView:_notificationLabel];
        _notificationLabel.textColor = [UIColor whiteColor];
        _notificationLabel.backgroundColor = [SPVisualFactory darkNavigationBarBackgroundColor];
    }
    return _notificationLabel;
}

#pragma mark - Actions

- (void)chatButtonTouched:(SPButton *)sender
{
    // show chat conversation
    [self showChatConversationViewController];
}

- (void)showChatConversationViewController
{
    SPNavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"SPChatConversationNavigationController"];
    SPChatConversationViewController *ChatViewController = (SPChatConversationViewController *)navigationController.topViewController;
    ChatViewController.delegate = self;
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Notifications message

- (void)notificationMessageDidUpdate
{
    [self updateContentInsets];
}

- (void)setNotificationMessage:(NSString *)notificationMessage
{
    self.notificationLabel.text = notificationMessage;
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    [self updateNotificationMessageVisibility];
    [self notificationMessageDidUpdate];
}

- (NSString *)notificationMessage
{
    if (self.notificationLabel.text.length == 0)
        return nil;
    return self.notificationLabel.text;
}

- (void)updateNotificationMessageVisibility
{
    if (self.notificationMessage)
    {
        self.notificationLabel.hidden = NO;
    }
    else
    {
        self.notificationLabel.hidden = YES;
    }
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

#pragma mark - SPChatConversationViewController delegate

- (void)chatConversationViewControllerDidEndConversation:(SPChatConversationViewController *)vc
{
    // dissmiss vc
    [vc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[SPViewController firstResponderInView:self.view] resignFirstResponder];
}

#pragma mark - Content size

- (UIEdgeInsets)currentContentInsets
{
    UIEdgeInsets insets = [super currentContentInsets];
    
    if (self.notificationMessage)
        insets.top += self.notificationLabel.bounds.size.height;
    return insets;
}

#pragma mark - Interface

- (void)setupUI
{
    [super setupUI];

    if (self.showsChat)
    {
        // add Chat button in view
        [self.view addSubview:self.chatButton];
    }
    
    if (self.showsAlgoliaSearch)
    {
        // add Algolia search view controller
        [self addChildViewController:self.algoliaSearchViewController];
        [self.view addSubview:self.algoliaSearchViewController.view];
        self.algoliaSearchViewController.delegate = self;
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

- (CGFloat)chatButtonOverHeight
{
    if (self.showsChat)
        return self.chatButton.frame.size.height + 10.0f;
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
    
    if (self.showsChat)
    {
        // place chat button
        self.chatButton.frame = CGRectMake((self.view.frame.size.width - self.chatButton.frame.size.width) / 2.0f,
                                              self.view.frame.size.height - self.chatButton.frame.size.height - 10.0f,
                                              self.chatButton.frame.size.width,
                                              self.chatButton.frame.size.height);
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
    
    height = [SPFontTailor sizeForText:self.notificationMessage width:self.view.frame.size.width font:self.notificationLabel.font].height + 20.0f;
    self.notificationLabel.bounds = CGRectMake(0.0f,
                                              0.0f,
                                              self.view.bounds.size.width,
                                              height);
    self.notificationLabel.center = CGPointMake(self.view.frame.size.width / 2.0f, height / 2.0f);
}

#pragma mark - View lifecyle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.notificationLabel];
    [self updateNotificationMessageVisibility];
    [self updateContentInsets];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [[SPViewController firstResponderInView:self.view] resignFirstResponder];
    [[SPViewController firstEditingView:self.view] resignFirstResponder];
}

@end
