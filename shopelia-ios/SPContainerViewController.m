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

- (SPButton *)chatButton
{
    if (!_chatButton)
    {
        UIImage *image = [UIImage imageNamed:@"btn_chat_normal.png"];
        _chatButton = [[SPButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [_chatButton setImage:image forState:UIControlStateNormal];
        [_chatButton setImage:[UIImage imageNamed:@"btn_chat_hover.png"] forState:UIControlStateHighlighted];
        [_chatButton addTarget:self action:@selector(chatButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chatButton;
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
        return [self.chatButton imageForState:UIControlStateNormal].size.height + 10.0f;
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
}

#pragma mark - View lifecyle

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [[SPViewController firstResponderInView:self.view] resignFirstResponder];
    [[SPViewController firstEditingView:self.view] resignFirstResponder];
}

@end
