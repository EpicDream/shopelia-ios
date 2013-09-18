//
//  productListViewController.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/18/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "productListViewController.h"

@interface productListViewController ()

@end

@implementation productListViewController

@synthesize shippingPrice;
@synthesize productImageView;
@synthesize priceTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customBackButton];
    

    
    [self.productImageView setAsynchImageWithURL:[self.product valueForKey:@"image_url"]];
    
    self.productTitle.text =  [self.product valueForKey:@"name"];
    
    priceTableView = [[UITableView alloc] initWithFrame:CGRectMake(20,40 + self.productImageView.Height + self.productTitle.Height ,self.productImageView.Width,200) style:UITableViewStyleGrouped];
    priceTableView.dataSource = self;
    priceTableView.delegate = self;
    priceTableView.scrollEnabled = NO;
    [self.scrollView addSubview:priceTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    
    
    CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in self.scrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    
    self.scrollView.contentSize= CGSizeMake(200.0,scrollViewHeight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDelegate 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    cell.textLabel.text = @"test";
    
    return cell;
    
}

@end
