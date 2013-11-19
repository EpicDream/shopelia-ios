//
//  SPInspirationalCollectionsViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPInspirationalCollectionsViewController.h"
#import "SPInspirationalCollectionCell.h"
#import "SPAPIClient+InspirationalCollections.h"
#import "SPInspirationalCollection.h"
#import "SPInspirationalCollectionProductsViewController.h"

@interface SPInspirationalCollectionsViewController() <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *collections; // of SPInspirationalCollection
@property (strong, nonatomic) SPAPIRequest *fetchRequest;
@end

@implementation SPInspirationalCollectionsViewController

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SHOW_INSPIRATIONAL_COLLECTION_PRODUCTS"])
    {
        SPInspirationalCollectionProductsViewController *vc = (SPInspirationalCollectionProductsViewController *)segue.destinationViewController;
        vc.collection = sender;
    }
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPInspirationalCollection *collection = [self.collections objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"SHOW_INSPIRATIONAL_COLLECTION_PRODUCTS" sender:collection];
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.collections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPInspirationalCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPInspirationalCollectionCell"];
    SPInspirationalCollection *collection = [self.collections objectAtIndex:indexPath.row];
    
    [cell configureWithInspirationalCollection:collection];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPInspirationalCollection *collection = [self.collections objectAtIndex:indexPath.row];
    
    if (collection.imageSize.width > 0)
    {
        CGFloat imageHeight = ceil(collection.imageSize.height * ((tableView.bounds.size.width - 22.0f) / collection.imageSize.width));
        return imageHeight + 10.0f;
    }
    return 100.0f;
}

#pragma mark - Interface

- (void)setupUI
{
    [super setupUI];
    
    [self.errorMessageView.actionButton addTarget:self action:@selector(reloadCollections) forControlEvents:UIControlEventTouchUpInside];
    [self.errorMessageView.actionButton setTitle:NSLocalizedString(@"Retry", nil) forState:UIControlStateNormal];
    [self.waitingMessageView.messageLabel setText:NSLocalizedString(@"PleaseWaitWhileLoadingCollections", nil)];
}

- (void)setupUIForContentView
{
    [super setupUIForContentView];
    
    self.tableView.hidden = NO;
}

- (void)setupUIForErrorMessageView
{
    [super setupUIForErrorMessageView];
    
    self.tableView.hidden = YES;
}

- (void)setupUIForWaitingMessageView
{
    [super setupUIForWaitingMessageView];
    
    self.tableView.hidden = YES;
}

#pragma mark - Actions

- (void)cancelViewController
{
    [self stopFetchRequest];
    
    [super cancelViewController];
}

- (void)reloadCollections
{
    [self setupUIForWaitingMessageView];
    [self startFetchRequest];
}

#pragma mark - Requests

- (void)startFetchRequest
{
    [self stopFetchRequest];
    
    self.fetchRequest = [[SPAPIV1Client sharedInstance] fetchInspirationalCollections:@[@"__Home"]
                                                                           completion:^(SPAPIError *error, NSArray *collections) {
        if (error || collections.count == 0)
        {
            self.errorMessageView.messageLabel.text = NSLocalizedString(@"ErrorUnableToFetchInspirationalCollections", nil);
            [self setupUIForErrorMessageView];
        }
        else
        {
            // update model
            self.collections = collections;
            
            // update view
            [self.tableView reloadData];
            [self setupUIForContentView];
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
    
    // analytics
    [[SPShopeliaAnalyticsTracker sharedInstance] trackHome];
    [[SPTracesAPIClient sharedInstance] traceHomeView];
    
    if (self.collections.count == 0)
        [self reloadCollections];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self stopFetchRequest];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

@end
