//
//  SPProductSearchViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 25/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPProductSearchViewController.h"
#import "SPProductSearchCell.h"
#import "SPSearchInProgressView.h"
#import "SPErrorMessageView.h"
#import "SPAPIClient+BarcodeSearch.h"
#import "SPAPIClient+ProductPrices.h"
#import "SPProductSearchInProgressCell.h"
#import "SPShopeliaManager.h"

#define TABLE_VIEW_PRODUCT_CELL_IDENFITIER @"SPProductSearchCell"
#define TABLE_VIEW_SEARCH_IN_PROGRESS_IDENTIFIER @"SPProductSearchInProgressCell"

@interface SPProductSearchViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet SPLabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet SPImageView *productImageView;

@property (strong, nonatomic) NSDictionary *product;
@property (strong, nonatomic) NSArray *products;
@property (strong, nonatomic) SPSearchInProgressView *searchInProgressView;
@property (strong, nonatomic) SPErrorMessageView *errorMessageView;
@property (strong, nonatomic) SPAPIRequest *productRequest;
@property (strong, nonatomic) SPAPIRequest *pricesRequest;
@property (strong, nonatomic) NSMutableArray *cellHeightsCache;
@end

@implementation SPProductSearchViewController

#pragma mark - Lazy instantiation

- (SPSearchInProgressView *)searchInProgressView
{
    if (!_searchInProgressView)
    {
        _searchInProgressView = [SPSearchInProgressView instanciateFromNibInBundle:[NSBundle mainBundle]];
    }
    return _searchInProgressView;
}

- (SPErrorMessageView *)errorMessageView
{
    if (!_errorMessageView)
    {
        _errorMessageView = [SPErrorMessageView instanciateFromNibInBundle:[NSBundle mainBundle]];
        [_errorMessageView.actionButton addTarget:self action:@selector(cancelViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _errorMessageView;
}

#pragma mark - Actions

- (void)cancelViewController
{
    [self stopProductRequest];
    [self stopPricesRequest];
    
    [super cancelViewController];
}

- (void)offerButtonTouched:(SPButton *)sender
{
    SPProduct *product = [self.products objectAtIndex:sender.tag - 1000];

    [SPShopeliaManager showShopeliaSDKForURL:product.URL fromViewController:self];
}

- (void)merchantButtonTouched:(SPButton *)sender
{
    SPProduct *product = [self.products objectAtIndex:sender.tag - 2000];
    
    SPNavigationController *navigationController = [[SPNavigationController alloc] init];
    SPWebNavigatorViewController *webNavigation = [[SPWebNavigatorViewController alloc] init];
    [webNavigation setInitialURL:product.URL];
    [navigationController setViewControllers:@[webNavigation]];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // searching cell
    if (self.product.count == 0)
        return 1;
    
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // searching cell
    if (self.product.count == 0)
    {
        SPProductSearchInProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_SEARCH_IN_PROGRESS_IDENTIFIER];
        
        return cell;
    }
    
    SPProductSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_PRODUCT_CELL_IDENFITIER];
    SPProduct *product = [self.products objectAtIndex:indexPath.row];
    
    [cell configureWithProduct:product];
    [cell.actionButton setTag:indexPath.row + 1000];
    [cell.merchantButton setTag:indexPath.row + 2000];
    [cell.actionButton addTarget:self action:@selector(offerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [cell.merchantButton addTarget:self action:@selector(merchantButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0f;
    
    // searching cell
    if (self.product.count == 0)
        return 100.0f;
        
    if ([[self.cellHeightsCache objectAtIndex:indexPath.row] class] == [NSNull class])
    {
        SPProductSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_PRODUCT_CELL_IDENFITIER];
        SPProduct *product = [self.products objectAtIndex:indexPath.row];
        
        [cell configureWithProduct:product];
        height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        [self.cellHeightsCache replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:height]];
    }
    {
        height = [[self.cellHeightsCache objectAtIndex:indexPath.row] floatValue];
    }
    return height;
}

#pragma mark - Interface

- (void)setupUI
{
    [super setupUI];
}

- (void)setupUIForProductRequest
{
    [self.tableView setHidden:YES];
    [self.view addSubview:self.searchInProgressView];
    [self.errorMessageView removeFromSuperview];
}

- (void)setupUIForPricesRequest
{
    [self.tableView setHidden:NO];
    [self.searchInProgressView removeFromSuperview];
    [self.errorMessageView removeFromSuperview];
}

- (void)setupUIForErrorMessage
{
    [self.tableView setHidden:YES];
    [self.searchInProgressView removeFromSuperview];
    [self.view addSubview:self.errorMessageView];
}

- (void)updateProductInformation
{
    self.productTitleLabel.text = [self.product objectForKey:@"name"];
    [self.productImageView setAsynchImageWithURL:[NSURL URLWithString:[self.product objectForKey:@"image_url"]]];
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame;
    frame = self.searchInProgressView.frame;
    frame.size.height = [self.searchInProgressView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    frame.size.width = self.view.bounds.size.width - 20.0f;
    frame.origin.x = 10.0f;
    frame.origin.y = (self.view.bounds.size.height - frame.size.height) / 2.0f;
    self.searchInProgressView.frame = frame;
    
    frame = self.errorMessageView.frame;
    frame.size.height = [self.errorMessageView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    frame.size.width = self.view.bounds.size.width - 20.0f;
    frame.origin.x = 10.0f;
    frame.origin.y = (self.view.bounds.size.height - frame.size.height) / 2.0f;
    self.errorMessageView.frame = frame;
}

#pragma mark - Requests

- (void)startProductRequest
{
    self.productRequest = [[SPAPIV1Client sharedInstance] fetchProductWithBarcode:self.barcode
                                                fromScanner:self.fromScanner
                                                 completion:^(SPAPIError *error, NSDictionary *product) {
        if (error)
        {
            self.errorMessageView.messageLabel.text = error.localizedMessage;
            [self setupUIForErrorMessage];
        }
        else
        {
            // update model
            self.product = product;
            
            // update view
            [self updateProductInformation];
            [self setupUIForPricesRequest];
            
            // update tableview header height
            [self.tableView.tableHeaderView setNeedsLayout];
            [self.tableView.tableHeaderView layoutIfNeeded];
            CGRect frame = self.tableView.tableHeaderView.frame;
            frame.size.height = [self.tableView.tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            self.tableView.tableHeaderView.frame = frame;
            [self.tableView setTableHeaderView:self.tableView.tableHeaderView];
            
            // fetch prices
            [self startPricesRequest];
        }
    }];
}

- (void)stopProductRequest
{
    [self.productRequest cancelAndClearCompletionBlock];
    self.productRequest = nil;
}

- (void)startPricesRequest
{
    NSArray *productURLs = [self.product objectForKey:@"urls"];
    
    self.pricesRequest = [[SPAPIV1Client sharedInstance] fetchProductPrices:productURLs completion:^(BOOL timeout, SPAPIError *error, NSArray *products) {
        if (timeout || error || products.count == 0)
        {
            if (timeout)
                self.errorMessageView.messageLabel.text = NSLocalizedString(@"ErrorUnableToFindPricesForThisProductOnline", nil);
            else
                self.errorMessageView.messageLabel.text = error.localizedMessage;
            [self setupUIForErrorMessage];
        }
        else
        {
            // update model
            self.products = products;
            
            // cell height cache
            self.cellHeightsCache = [[NSMutableArray alloc] initWithCapacity:self.products.count];
            for (NSUInteger i = 0; i < self.products.count; i++)
                [self.cellHeightsCache addObject:[NSNull null]];
            
            // update view
            [self.tableView reloadData];
        }
    }];
}

- (void)stopPricesRequest
{
    [self.pricesRequest cancelAndClearCompletionBlock];
    self.pricesRequest = nil;
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if ([self.product count] == 0)
    {
        // fetch product
        [self setupUIForProductRequest];
        [self startProductRequest];
    }
    else if (self.products.count == 0)
    {
        // fetch prices
        [self setupUIForPricesRequest];
        [self startPricesRequest];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self stopProductRequest];
    [self stopPricesRequest];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

@end