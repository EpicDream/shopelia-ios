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
    
    NSLog(@"%@",self.products);
    [self getCheaperProduct];
    NSLog(@"%@",self.cheaperProduct);
    
    UIImageView *logo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"logo-word.png" ]];
    self.navigationItem.titleView = logo ;
    UIView *view = self.contentView;
    view.layer.cornerRadius =  8.0;
    
    NSMutableAttributedString *shipping = [[NSMutableAttributedString alloc] initWithAttributedString:[OHASBasicHTMLParser attributedStringByProcessingMarkupInString:@"<b><font name='Arial' size='13'><font color='#39ADBB'>allo</font></font></b>"]];
    self.shippingPrice.attributedText = shipping;
    
    // Do any additional setup after loading the view from its nib.
}

-(void) getCheaperProduct {
    if (self.products == nil || self.products.count < 1 ) {
        NSLog(@"Someething wrong with Product Array : %@",self.products);
    } else if(self.products.count == 1) {
        self.cheaperProduct  = [self.products objectAtIndex:0];
    } else {
        NSDictionary *result = [[NSDictionary alloc] initWithDictionary:[self.products objectAtIndex:0]];
        for (int i=1;i<self.products.count;i++) {
            NSDictionary *version = [[NSDictionary alloc] initWithDictionary:[[result objectForKey: @"versions"] objectAtIndex:0]];
            float totalPrice = [[version valueForKey:@"price"] floatValue] + [[version valueForKey:@"price_shipping"] floatValue] - [[version valueForKey:@"cashfront_value"] floatValue];
            NSDictionary *temp = [self.products objectAtIndex:i];
            NSDictionary *tempVersion = [[temp objectForKey:@"versions" ] objectAtIndex:0];
            float tempTotalPrice = [[tempVersion valueForKey:@"price"] floatValue] + [[tempVersion valueForKey:@"price_shipping"] floatValue]- [[tempVersion valueForKey:@"cashfront_value"] floatValue];
            if (tempTotalPrice < totalPrice) {
                result = temp;
            }
        }
        
        self.cheaperProduct = result;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
