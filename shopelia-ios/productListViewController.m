//
//  productListViewController.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/18/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "productListViewController.h"
#import "SPCell.h"
#import "UIColor+Shopelia.h"

@interface productListViewController ()

@end

@implementation productListViewController

@synthesize shippingPrice;
@synthesize productImageView;
@synthesize priceTableView;

static const int CELL_HEIGHT = 82;


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
    //[self customBackButton];
    [self.productImageView setAsynchImageWithURL:[self.product valueForKey:@"image_url"]];
    
    self.productTitle.text =  [self.product valueForKey:@"name"];
    self.priceTableView.contentInset = UIEdgeInsetsMake(0, 0,10, 0);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    SPCell *cell = (SPCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SPCell" owner:nil options:nil];
        
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (SPCell *) currentObject;
                int rowsInSection = [self tableView:tableView numberOfRowsInSection:indexPath.section];
                if (rowsInSection == 1) {
                    cell.position = CellPositionSingle;
                } else {
                    if (indexPath.row == 0) {
                        cell.position = CellPositionTop;
                    } else if (indexPath.row == rowsInSection - 1) {
                        cell.position = CellPositionBottom;
                    } else {
                        cell.position = CellPositionMiddle;
                    }
                }
                [cell updateContentView];

                break;
            }
        }
    }
    NSDictionary* prod = [self.products objectAtIndex:indexPath.row];
    NSDictionary* version = [self getVersion:prod];
    NSLog(@"%@",version);
    // Configure the cell...
    cell.price.text = [[version valueForKey:@"price"] stringValue];
    cell.soldBy.text = [[prod objectForKey:@"merchant"] valueForKey:@"domain"];
    cell.shippingInfos.text = [version valueForKey:@"shipping_info"];

    
    return cell;
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (void)tableView:(UITableView *)currentTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Launch Shopelia
}




@end
