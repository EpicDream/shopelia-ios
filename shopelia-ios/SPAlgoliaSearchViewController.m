//
//  SPAlgoliaSearchViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 29/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAlgoliaSearchViewController.h"
#import "SPSearchBar.h"
#import "SPAlgoliaAPIClient.h"
#import "SPShopeliaManager.h"
#import "SPAlgoliaSearchResult.h"
#import "SPGridCollectionViewCell.h"
#import "SPCollectionView.h"
#import "CHTCollectionViewWaterfallLayout.h"

#define PRODUCT_CELL_WIDTH 145.0f
#define SECTION_HEADER_HEIGHT 64.0f

@interface SPAlgoliaSearchViewController ()  <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet SPSearchBar *searchBar;
@property (strong, nonatomic) NSTimer *searchTimer;
@property (strong, nonatomic) NSArray *searchResults; // of SPAlgoliaSearchResult
@property (assign, nonatomic) NSUInteger currentPageNumber;
@property (assign, nonatomic) NSUInteger totalPagesNumber;
@property (weak, nonatomic) IBOutlet SPCollectionView *collectionView;
@property (strong, nonatomic) NSString *lastSearchQuery;
@end

@implementation SPAlgoliaSearchViewController

#pragma mark - Algolia search

- (void)performAlgoliaSearch:(NSString *)query appendResults:(BOOL)append pageNumber:(NSUInteger)page
{
    // cancel previous searches
    [[SPAlgoliaAPIClient sharedInstance] cancelSearches];
    
    if (query.length < 3)
    {
        self.searchResults = @[];
        [self.collectionView reloadData];
        [self updateCollectionViewVisibility];
        return ;
    }
    
    // analytics
    [[SPShopeliaAnalyticsTracker sharedInstance] fromTextualSearch:query];
    [[SPTracesAPIClient sharedInstance] traceSearchRequest:query];
    
    // launch new search
    [[SPAlgoliaAPIClient sharedInstance] searchProductsWithQuery:query page:page completion:^(BOOL success, NSArray *searchResults, NSUInteger pagesNumber) {
    
        if (success && pagesNumber > 0)
        {
            self.totalPagesNumber = pagesNumber;

            if (append)
            {
                // append results
                NSMutableArray *array = [NSMutableArray arrayWithArray:self.searchResults ? self.searchResults : @[]];
                [array addObjectsFromArray:searchResults];
                self.searchResults = array;
            }
            else
            {
                // replace results
                [self.collectionView setContentOffset:CGPointMake(0, 0)];
                self.searchResults = searchResults;
            }
        }
        else
        {
            self.searchResults = nil;
        }
        
        [self.collectionView reloadData];
        [self updateCollectionViewVisibility];
    }];
}

- (void)searchTimerFired:(NSTimer *)timer
{
    // destroy timer
    [timer invalidate];
    self.searchTimer = nil;
    
    // perform query
    [self performAlgoliaSearch:self.lastSearchQuery appendResults:NO pageNumber:self.currentPageNumber];
}

#pragma mark - UISearchBar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // invalidate timer
    [self.searchTimer invalidate];
    self.searchTimer = nil;
    
    // search params
    self.lastSearchQuery = [SPDataConvertor stringByTrimmingString:searchText];
    self.currentPageNumber = 0;
    self.totalPagesNumber = 0;
    
    // reschelude new search
    self.searchTimer = [NSTimer timerWithTimeInterval:0.3f target:self selector:@selector(searchTimerFired:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.searchTimer forMode:NSRunLoopCommonModes];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // analytics
    [[SPTracesAPIClient sharedInstance] traceSearchView];
}

#pragma mark - CHTCollectionViewWaterfallLayout delegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(CHTCollectionViewWaterfallLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPAlgoliaSearchResult *searchResult = [self.searchResults objectAtIndex:indexPath.row];
    SPProduct *product = searchResult.product;
    
    CGFloat imageHeight = 100.0f;
    if (product.imageSize.width > 0 && product.imageSize.height)
        imageHeight = ceil(product.imageSize.height * ((PRODUCT_CELL_WIDTH - 20.0f) / product.imageSize.width));
    return 30.0f + 10.0f + imageHeight + 10.0f;
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPAlgoliaSearchResult *searchResult = [self.searchResults objectAtIndex:indexPath.row];

    // analytics
    [[SPShopeliaAnalyticsTracker sharedInstance] setURL:[searchResult.product.URL absoluteString]];
    
    [self.delegate algoliaSearchViewController:self didSelectSearchResult:searchResult];
}

#pragma mark - UICollectionView data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPGridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SPGridCollectionViewCell" forIndexPath:indexPath];
    SPAlgoliaSearchResult *searchResult = [self.searchResults objectAtIndex:indexPath.row];
    SPProduct *product = searchResult.product;
    
    [cell configureWithProduct:product];
    return cell;
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentSize.height > 0 &&
        (scrollView.contentOffset.y + scrollView.bounds.size.height) >= (scrollView.contentSize.height * 0.80f) &&
        ![[SPAlgoliaAPIClient sharedInstance] isSearching] &&
        (self.currentPageNumber + 1) < self.totalPagesNumber)
    {
        // perform query
        self.currentPageNumber++;
        [self performAlgoliaSearch:self.lastSearchQuery appendResults:YES pageNumber:self.currentPageNumber];
    }
}

#pragma mark - Interface

- (void)setupUI
{
    [super setupUI];
    
    self.searchBar.placeholder = NSLocalizedString(@"SearchAProduct", nil);

    // configure search bar
    UIControl <UITextInputTraits> *subView = [self firstSubviewConformingToProtocol:@protocol(UITextInputTraits) inView:self.searchBar];
    [subView setKeyboardAppearance: UIKeyboardAppearanceAlert];
    [subView setReturnKeyType:UIReturnKeyDone];
    
    CHTCollectionViewWaterfallLayout *collectionViewLayout = (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    [collectionViewLayout setItemWidth:PRODUCT_CELL_WIDTH];
    [collectionViewLayout setColumnCount:2];
    [collectionViewLayout setSectionInset:UIEdgeInsetsMake(SECTION_HEADER_HEIGHT, 10.0f, self.chatButtonOverHeight + 10.0f, 10.0f)];
    
    self.collectionView.backgroundColor = [SPVisualFactory defaultBackgroundColor];
    [self updateCollectionViewVisibility];
    
    self.errorMessageView.messageLabel.text = NSLocalizedString(@"NoResultsForThisQuery", nil);
    [self.errorMessageView.actionButton removeFromSuperview];
}

- (void)setupUIForContentView
{
    [super setupUIForContentView];
    
    self.collectionView.hidden = NO;
}

- (void)setupUIForErrorMessageView
{
    [super setupUIForErrorMessageView];
    
    self.collectionView.hidden = YES;
}

- (id)firstSubviewConformingToProtocol:(Protocol *)protocol inView:(UIView *)view
{
    if ([view conformsToProtocol:protocol])
        return view;
    
    for (UIView *sub in view.subviews)
    {
        UIView *ret = [self firstSubviewConformingToProtocol:protocol inView:sub];
        if (ret)
            return ret;
    }
    
    return nil;
}

- (void)updateCollectionViewVisibility
{
    [self setupUIForContentView];

    if ([self shouldDisplayNoResultsCell] || self.searchResults.count > 0)
    {
        if ([self shouldDisplayNoResultsCell])
            [self setupUIForErrorMessageView];
            
        self.collectionView.hidden = NO;
    }
    else
    {
        self.collectionView.hidden = YES;
    }
    
    self.chatButton.hidden = self.collectionView.hidden;
}

- (BOOL)shouldDisplayNoResultsCell
{
    return (self.searchResults.count == 0 && self.lastSearchQuery.length >= 3);
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.errorMessageView.frame;
    frame.origin.y = SECTION_HEADER_HEIGHT;
    self.errorMessageView.frame = frame;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    

}

@end
