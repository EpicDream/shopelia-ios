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
@synthesize products;
@synthesize productImageView;
@synthesize product;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
