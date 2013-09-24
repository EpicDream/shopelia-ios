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
#import <ShopeliaSDK/ShopeliaSDK.h>
#import "HTTPResponse.h"


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
    [self getAllProductInfosForUrls: self.urls
                withCompletionBlock: ^(BOOL timeout, NSError *error, HTTPResponse *response) {
                    //NSLog(@"%@",response.responseJSON);
                    //NSLog(@"%hhd", timeout);
                    if (!timeout) {
                        NSArray* resArray  = (NSArray *) response.responseJSON;
                        self.products = resArray;
                        [self comparePrices];
                        [self.priceTableView reloadData];
                    }
                }];

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
    //NSLog(@"%@",version);
    // Configure the cell...
    float price = [[version valueForKey:@"price"] floatValue] + [[version valueForKey:@"price_shipping"] floatValue] ;
    cell.price.text = [NSString stringWithFormat:@"%0.2f€" ,(round(price * 100)/100)];
    
    [cell formatMerchantUrl:prod];
    [cell formatShipping];
    cell.shippingInfos.text = [version valueForKey:@"shipping_info"];
    [cell.shopeliaBtn addTarget:self action:@selector(shopeliaInit:) forControlEvents:UIControlEventTouchUpInside];
    
    

    return cell;
    
}

- (void)shopeliaInit:(id)sender {
    //NSLog(@"%@",@"SHOPELIA INITIALISATION");
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.priceTableView];
    NSIndexPath *indexPath = [self.priceTableView indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {
         NSDictionary *prod = [self.products objectAtIndex:indexPath.row];
        Shopelia *shopelia = [[Shopelia alloc] init];
        [shopelia prepareOrderWithProductURL:[NSURL URLWithString: [prod valueForKey:@"url"] ] completion:^(NSError *error) {
                //NSLog(@"%@", error);
            [shopelia checkoutPreparedOrderFromViewController:self animated:YES completion:nil];
        }];
    }
    
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
