//
//  productViewController.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/11/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "productViewController.h"
#import <OHAttributedLabel/OHASBasicHTMLParser.h>


@interface productViewController ()

@end


@implementation productViewController

@synthesize shippingPrice;
@synthesize products;
@synthesize cheaperProduct;
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
    [self customBackButton];
    NSLog(@"%@",self.productImageView);
    [self.productImageView setAsynchImageWithURL:[self.product valueForKey:@"image_url"]];
    //self.productImageView = [[UIImageView alloc] initWithImage:self.productImage];
    [self getCheaperProduct];
    NSLog(@"%@",self.cheaperProduct);
    
    
    
    UIImageView *logo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"logo-word.png" ]];
    self.navigationItem.titleView = logo ;
    UIView *view = self.contentView;
    view.layer.cornerRadius =  4.0;
    NSDictionary *version =[self getVersion:self.cheaperProduct];
    //NSLog(@"VERSION: %@",version);
    self.productTitle.text =  [self.cheaperProduct valueForKey:@"name"];
    self.price.text = [[[version valueForKey:@"price"] stringValue] stringByAppendingString:@"€"];
    self.shippingPrice.text = [[version valueForKey:@"price_shipping"] stringValue];
    
    //[[NSString alloc] initWithFormat:@"<b><font name='Arial' size='13'><font color='#39ADBB'>%@</font></font></b>",price];
    
    [self formatMerchantUrl];
    [self formatShippingPrice];
    
    // Do any additional setup after loading the view from its nib.
}

- (void) formatMerchantUrl {
    NSMutableAttributedString *merchantUrlLabel = [[NSMutableAttributedString alloc] initWithAttributedString:[OHASBasicHTMLParser attributedStringByProcessingMarkupInString: [[NSString alloc] initWithFormat:@"par <font name='Arial' size='13'><font color='#2b9b82'><a href='%@'>%@</a></font></font>",[self.cheaperProduct valueForKey:@"url"],[[self.cheaperProduct objectForKey:@"merchant"] valueForKey:@"domain"]]]];
    self.soldBy.attributedText = merchantUrlLabel;
}

- (void) formatShippingPrice {
    NSString *formatedShippingPrice = [[NSString alloc] init];
    if([self.shippingPrice.text floatValue] == 0.0f){
        formatedShippingPrice = @"Livraison gratuite";
    } else {
        formatedShippingPrice = [[NSString alloc] initWithFormat:@"frais de livraison <b><font name='Arial' size='13'><font color='#2b9b82'>%@€</font></font></b>",self.shippingPrice.text];
    }
    
    NSMutableAttributedString *shipping = [[NSMutableAttributedString alloc] initWithAttributedString:[OHASBasicHTMLParser attributedStringByProcessingMarkupInString: formatedShippingPrice]];
    self.shippingPrice.attributedText = shipping;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
