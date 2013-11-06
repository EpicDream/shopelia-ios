//
//  SPInspirationalCollectionProductsViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPInspirationalCollectionProductsViewController.h"
#import "SPCollectionView.h"
#import "SPGridCollectionViewCell.h"
#import "SPAPIClient+InspirationalCollections.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "SPShopeliaManager.h"

#define PRODUCT_CELL_WIDTH 145.0f

@interface SPInspirationalCollectionProductsViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CHTCollectionViewDelegateWaterfallLayout>
@property (strong, nonatomic) NSArray *products; // of SPProduct
@property (strong, nonatomic) SPAPIRequest *fetchRequest;
@property (weak, nonatomic) IBOutlet SPCollectionView *collectionView;
@end

@implementation SPInspirationalCollectionProductsViewController

#pragma mark - CHTCollectionViewWaterfallLayout delegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(CHTCollectionViewWaterfallLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPProduct *product = [self.products objectAtIndex:indexPath.row];
    
    CGFloat imageHeight = 100.0f;
    if (product.imageSize.width > 0)
        imageHeight = ceil(product.imageSize.height * ((PRODUCT_CELL_WIDTH - 20.0f) / product.imageSize.width));
    return 30.0f + 10.0f + imageHeight + 10.0f;
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPProduct *product = [self.products objectAtIndex:indexPath.row];
    
    [SPShopeliaManager showShopeliaSDKForURL:product.URL fromViewController:self];
}

#pragma mark - UICollectionView data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPGridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SPGridCollectionViewCell" forIndexPath:indexPath];
    SPProduct *product = [self.products objectAtIndex:indexPath.row];
    
    [cell configureWithProduct:product];
    return cell;
}

#pragma mark - Interface

- (void)setupUI
{
    [super setupUI];
    
    [self.errorMessageView.actionButton addTarget:self action:@selector(reloadCollectionProducts) forControlEvents:UIControlEventTouchUpInside];
    [self.errorMessageView.actionButton setTitle:NSLocalizedString(@"Retry", nil) forState:UIControlStateNormal];
    [self.waitingMessageView.messageLabel setText:NSLocalizedString(@"PleaseWaitWhileLoadingProducts", nil)];
    
    CHTCollectionViewWaterfallLayout *collectionViewLayout = (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    [collectionViewLayout setItemWidth:PRODUCT_CELL_WIDTH];
    [collectionViewLayout setColumnCount:2];
    [collectionViewLayout setSectionInset:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
}

- (void)setupUIForWaitingView
{
    [self.errorMessageView removeFromSuperview];
    [self.view insertSubview:self.waitingMessageView atIndex:0];
    [self.collectionView setHidden:YES];
}

- (void)setupUIForErrorMessageView
{
    [self.waitingMessageView removeFromSuperview];
    [self.collectionView setHidden:YES];
    [self.view insertSubview:self.errorMessageView atIndex:0];
}

- (void)setupUIForCollectionProducts
{
    [self.waitingMessageView removeFromSuperview];
    [self.errorMessageView removeFromSuperview];
    [self.collectionView setHidden:NO];
}

#pragma mark - Actions

- (void)cancelViewController
{
    [self stopFetchRequest];
    
    [super cancelViewController];
}

- (void)reloadCollectionProducts
{
    [self setupUIForWaitingView];
    [self startFetchRequest];
}

#pragma mark - Requests

- (void)startFetchRequest
{
    [self stopFetchRequest];
    
    self.fetchRequest = [[SPAPIV1Client sharedInstance] fetchInspirationalCollectionProducts:self.collection completion:^(SPAPIError *error, NSArray *products) {
        if (error || products.count == 0)
        {
            self.errorMessageView.messageLabel.text = NSLocalizedString(@"ErrorUnableToFetchInspirationalCollectionProducts", nil);
            [self setupUIForErrorMessageView];
        }
        else
        {
            // update model
            self.products = products;
            
            // update view
            [self.collectionView reloadData];
            [self setupUIForCollectionProducts];
        }
    }];
}

- (void)stopFetchRequest
{
    [self.fetchRequest cancelAndClearCompletionBlock];
    self.fetchRequest = nil;
}


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.products.count == 0)
        [self reloadCollectionProducts];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self stopFetchRequest];
}

@end
