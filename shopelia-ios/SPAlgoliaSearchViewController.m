//
//  SPAlgoliaSearchViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 29/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAlgoliaSearchViewController.h"
#import "SPSearchBar.h"
#import "SPAlgoliaSearchCell.h"
#import "SPAlgoliaAPIClient.h"
#import "SPShopeliaManager.h"
#import "SPAlgoliaSearchResult.h"

#define TABLE_VIEW_ALGOLIA_SEARCH_CELL_IDENTIFIER @"SPAlgoliaSearchCell"

@interface SPAlgoliaSearchViewController ()  <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet SPSearchBar *searchBar;
@property (strong, nonatomic) NSTimer *searchTimer;
@property (strong, nonatomic) NSArray *searchResults;
@property (assign, nonatomic) NSUInteger currentPageNumber;
@end

@implementation SPAlgoliaSearchViewController

#pragma mark - Algolia search

- (void)searchTimerFired:(NSTimer *)timer
{
    [[SPAlgoliaAPIClient sharedInstance] searchProductsWithQuery:timer.userInfo
                                                            page:self.currentPageNumber
                                                      completion:^(BOOL success, NSArray *products) {
        if (success)
        {
            self.searchResults = products;
            [self.tableView reloadData];
            [self updateTableViewVisibility];
        }
    }];
    
    // destroy timer
    [timer invalidate];
    self.searchTimer = nil;
}

#pragma mark - UISearchBar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // invalidate timer
    [self.searchTimer invalidate];
    
    // search string
    NSString *trimmedText = [SPDataConvertor stringByTrimmingString:searchText];
    
    if (trimmedText.length >= 3)
    {
        // reschelude new search
        self.searchTimer = [NSTimer scheduledTimerWithTimeInterval:0.3f
                                                            target:self
                                                          selector:@selector(searchTimerFired:)
                                                          userInfo:trimmedText
                                                           repeats:NO];
    }
    else
    {
        self.searchResults = @[];
        [self.tableView reloadData];
        [self updateTableViewVisibility];
    }
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPAlgoliaSearchResult *searchResult = [self.searchResults objectAtIndex:indexPath.row];
    
    // notify delegate
    [self.delegate algoliaSearchViewController:self didSelectSearchResult:searchResult];
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPAlgoliaSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_ALGOLIA_SEARCH_CELL_IDENTIFIER];
    SPAlgoliaSearchResult *searchResult = [self.searchResults objectAtIndex:indexPath.row];
    
    cell.productTitleLabel.text = searchResult.product.name;
    [cell.productImageView setImage:nil];
    [cell.productImageView setAsynchImageWithURL:searchResult.product.imageURL];
    return cell;
}

#pragma mark - UIScrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
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
    
    self.tableView.backgroundColor = [SPVisualFactory defaultBackgroundColor];
    self.tableView.hidden = YES;
}

- (id)firstSubviewConformingToProtocol:(Protocol *)pro inView:(UIView *)view
{
    if ([view conformsToProtocol: pro])
        return view;
    
    for (UIView *sub in view.subviews)
    {
        UIView *ret = [self firstSubviewConformingToProtocol:pro inView:sub];
        if (ret)
            return ret;
    }
    
    return nil;
}

- (void)updateTableViewVisibility
{
    if (self.searchResults.count > 0)
    {
        self.tableView.hidden = NO;
    }
    else
    {
        self.tableView.hidden = YES;
    }
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    

}

@end
