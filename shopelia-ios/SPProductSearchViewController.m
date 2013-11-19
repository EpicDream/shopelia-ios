//
//  SPProductSearchViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 25/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPProductSearchViewController.h"
#import "SPProductSearchCell.h"
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
@property (strong, nonatomic) NSArray *products; // of SPProducts
@property (strong, nonatomic) SPAPIRequest *productRequest;
@property (strong, nonatomic) SPAPIRequest *pricesRequest;
@property (strong, nonatomic) NSMutableArray *cellHeightsCache;
@end

@implementation SPProductSearchViewController

#pragma mark - Actions

- (void)cancelViewController
{
    // analytics
    [[SPShopeliaAnalyticsTracker sharedInstance] trackErrorCancel];
    
    [self stopProductRequest];
    [self stopPricesRequest];
    
    [super cancelViewController];
}

- (void)offerButtonTouched:(SPButton *)sender
{
    SPProduct *product = [self.products objectAtIndex:sender.tag - 1000];

    // analytics
    [[SPShopeliaAnalyticsTracker sharedInstance] setURL:[product.URL absoluteString]];
    
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

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[SPProductSearchInProgressCell class]])
    {
        [((SPProductSearchInProgressCell *)cell).spinner startAnimating];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[SPProductSearchInProgressCell class]])
    {
        [((SPProductSearchInProgressCell *)cell).spinner stopAnimating];
    }
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
        return 132.0f;
        
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
    
    [self.errorMessageView.actionButton addTarget:self action:@selector(cancelViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.errorMessageView.actionButton setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateNormal];
    [self.waitingMessageView.messageLabel setText:NSLocalizedString(@"ProductSearchInProgress", nil)];
}

- (void)setupUIForContentView
{
    [super setupUIForContentView];
    
    self.tableView.hidden = NO;
    self.chatButton.hidden = YES;
}

- (void)setupUIForErrorMessageView
{
    [super setupUIForErrorMessageView];
    
    self.tableView.hidden = YES;
    self.chatButton.hidden = NO;
}

- (void)setupUIForWaitingMessageView
{
    [super setupUIForWaitingMessageView];
    
    self.tableView.hidden = YES;
    self.chatButton.hidden = YES;
}

- (void)updateProductInformation
{
    self.productTitleLabel.text = [self.product objectForKey:@"name"];
    [self.productImageView setAsynchImageWithURL:[NSURL URLWithString:[self.product objectForKey:@"image_url"]]];
}

#pragma mark - Requests

- (void)startProductRequest
{
    [self stopProductRequest];
    
    // analytics
    [[SPShopeliaAnalyticsTracker sharedInstance] trackSearch];
    
    self.productRequest = [[SPAPIV1Client sharedInstance] fetchProductWithBarcode:self.barcode
                                                fromScanner:self.fromScanner
                                                 completion:^(SPAPIError *error, NSDictionary *product) {
        if (error)
        {
            // analytics
            [[SPShopeliaAnalyticsTracker sharedInstance] trackErrorNoProduct];
            
            self.errorMessageView.messageLabel.text = error.localizedMessage;
            [self setupUIForErrorMessageView];
        }
        else
        {
            // update model
            self.product = product;
            
            // update view
            [self updateProductInformation];
            [self setupUIForContentView];
            
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
    [self stopPricesRequest];
    
    NSArray *productURLs = [self.product objectForKey:@"urls"];
    self.pricesRequest = [[SPAPIV1Client sharedInstance] fetchProductPrices:productURLs completion:^(BOOL timeout, SPAPIError *error, NSArray *products) {
        if (timeout || error || products.count == 0)
        {
            // analytics
            [[SPShopeliaAnalyticsTracker sharedInstance] trackErrorNoPrice];
            
            self.errorMessageView.messageLabel.text = NSLocalizedString(@"ErrorUnableToFindPricesForThisProductOnline", nil);
            [self setupUIForErrorMessageView];
        }
        else
        {
            // analytics
            [[SPShopeliaAnalyticsTracker sharedInstance] trackDisplayProduct];
            
            if (products.count == 1)
            {
                // show shopelia SDK
                SPProduct *product = products[0];
                
                [SPShopeliaManager showShopeliaSDKForURL:product.URL fromViewController:self completion:^{
                   [self cancelViewController];
                }];
            }
            else
            {
                self.chatButton.hidden = NO;
                
                // update model
                self.products = products;
                
                // cell height cache
                self.cellHeightsCache = [[NSMutableArray alloc] initWithCapacity:self.products.count];
                for (NSUInteger i = 0; i < self.products.count; i++)
                    [self.cellHeightsCache addObject:[NSNull null]];
                
                // update view
                [self.tableView reloadData];
            }
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
        [self setupUIForWaitingMessageView];
        [self startProductRequest];
    }
    else if (self.products.count == 0)
    {
        // fetch prices
        [self setupUIForContentView];
        [self startPricesRequest];
    }
    
    // analytics
    [[SPTracesAPIClient sharedInstance] traceProductView:self.barcode];
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
