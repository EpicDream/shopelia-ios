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
@synthesize productImageView;


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
    //NSLog(@"%@",self.productImageView);
    [self.productImageView setAsynchImageWithURL:[self.product valueForKey:@"image_url"]];
    [self getCheaperProduct];
    ////NSLog(@"%@",self.cheaperProduct);
    
    UIView *view = self.contentView;
    view.layer.cornerRadius =  4.0;
    NSDictionary *version =[self getVersion:self.cheaperProduct];
    ////NSLog(@"VERSION: %@",version);
    self.productTitle.text =  [self.cheaperProduct valueForKey:@"name"];
    self.price.text = [[[version valueForKey:@"price"] stringValue] stringByAppendingString:@"€"];
    self.shippingPrice.text = [[version valueForKey:@"price_shipping"] stringValue];    
    [self formatMerchantUrl];
    [self formatShippingPrice];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
