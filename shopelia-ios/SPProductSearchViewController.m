//
//  SPProductSearchViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 25/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPProductSearchViewController.h"
#import "SPProductSearchCell.h"

#define TABLE_VIEW_PRODUCT_CELL_IDENFITIER @"SPProductSearchCell"

@interface SPProductSearchViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet SPView *headerView;
@property (strong, nonatomic) SPProductSearchCell *offscreenCell;
@end

@implementation SPProductSearchViewController

#pragma mark - Lazy intantiation

- (SPProductSearchCell *)offscreenCell
{
    if (!_offscreenCell)
    {
        _offscreenCell = [[SPProductSearchCell alloc] init];
    }
    return _offscreenCell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"SELECTED = %@", indexPath);
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPProductSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_PRODUCT_CELL_IDENFITIER];
    [self customizeView:cell];
    [self translateView:cell];
    
    return cell;
}

#pragma mark - Interface

- (void)setupUI
{
    [super setupUI];
    
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.headerView.frame;
    frame.size.height = [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.headerView.frame = frame;
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
