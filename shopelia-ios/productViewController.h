//
//  productViewController.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/11/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPImageView.h"
#import "backgroundView.h"

@interface productViewController : UIViewController

@property (strong, nonatomic) IBOutlet backgroundView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *shippingPrice;
@property (strong, nonatomic) NSArray* products;
@property (strong, nonatomic) NSDictionary* cheaperProduct;
@property (strong, nonatomic) NSDictionary* product;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *soldBy;
@property (strong, nonatomic) IBOutlet UILabel *productTitle;
@property (strong, nonatomic) IBOutlet SPImageView *productImageView;



@end
