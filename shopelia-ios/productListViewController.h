//
//  productListViewController.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/18/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "backgroundView.h"
#import "baseProductViewController.h"
#import "shopeliaImageView.h"
#import "UIView+Shopelia.h"

@interface productListViewController : baseProductViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet backgroundView *contentView;
@property (strong, nonatomic) UILabel *shippingPrice;
@property (strong, nonatomic) NSArray* products;
@property (strong, nonatomic) NSDictionary* product;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *soldBy;
@property (strong, nonatomic) IBOutlet UILabel *productTitle;
@property (strong, nonatomic) IBOutlet shopeliaImageView *productImageView;
@property (strong, nonatomic) IBOutlet UITableView *priceTableView;
@property (strong, nonatomic) IBOutlet UIImageView *separatorImageView;
@property (assign, nonatomic) BOOL fromScanner;

@end
