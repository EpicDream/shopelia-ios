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

@interface SPContainerViewController () <SPAlgoliaSearchViewControllerDelegate, UIScrollViewDelegate>
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

@end
