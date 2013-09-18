//
//  baseProductViewController.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/18/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "baseProductViewController.h"
#import <OHAttributedLabel/OHASBasicHTMLParser.h>
#import "UIColor+Shopelia.h"
#import "UIView+Shopelia.h"


@interface baseProductViewController ()

@end

@implementation baseProductViewController

@synthesize products;
@synthesize cheaperProduct;
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
    [self customBackButton];
    UIImageView *logo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"logo-word.png" ]];
    self.navigationItem.titleView = logo ;
    
}



-(void) getCheaperProduct {
    if (self.products == nil || self.products.count < 1 ) {
        NSLog(@"Someething wrong with Product Array : %@",self.products);
    } else if(self.products.count == 1) {
        self.cheaperProduct  = [self.products objectAtIndex:0];
    } else {
        NSDictionary *result = [[NSDictionary alloc] initWithDictionary:[self.products objectAtIndex:0]];
        for (int i=1;i<self.products.count;i++) {
            NSDictionary *version = [self getVersion: result];
            float totalPrice = [[version valueForKey:@"price"] floatValue] + [[version valueForKey:@"price_shipping"] floatValue] - [[version valueForKey:@"cashfront_value"] floatValue];
            NSDictionary *temp = [self.products objectAtIndex:i];
            NSDictionary *tempVersion = [self getVersion: temp];
            float tempTotalPrice = [[tempVersion valueForKey:@"price"] floatValue] + [[tempVersion valueForKey:@"price_shipping"] floatValue]- [[tempVersion valueForKey:@"cashfront_value"] floatValue];
            if (tempTotalPrice < totalPrice) {
                result = temp;
            }
        }
        
        self.cheaperProduct = result;
    }
}




-(NSDictionary *) getVersion: (NSDictionary *) product {
    return [[product objectForKey:@"versions"] objectAtIndex:0];
}


- (void) customBackButton {
    UIImage *backImage = [UIImage imageNamed:@"back-button"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, backImage.size.width, backImage.size.height );
    [button setImage:backImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = item;
}


-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
