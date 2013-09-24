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
#import "HTTPRequest.h"
#import "HTTPPoller.h"


@interface baseProductViewController ()

@end

@implementation baseProductViewController

@synthesize products;
@synthesize cheaperProduct;
@synthesize product;
@synthesize urls;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[self fakeProducts];
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

-(void) getAllProductInfosForUrls: (NSMutableArray*) productUrls
              withCompletionBlock: (void (^)(BOOL timeout, NSError *error, id response))completionBlock
{
    
    
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    NSString *shopeliApiKey = [dict valueForKey:@"ShopeliaAPIKey"] ;
    HTTPRequest *request = [[HTTPRequest alloc] init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:productUrls forKey: @"urls"];
    //NSLog(@"%@",params);
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    
    request.HTTPBody = jsonData;
    [request setValue:shopeliApiKey forHTTPHeaderField:@"X-Shopelia-ApiKey"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *url =@"https://www.shopelia.com/api/products";
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    //NSLog(@"%@",request);
    
    [HTTPPoller pollRequest:request
                    maxTime:10.0f
            requestInterval:1.0f
               restartBlock:^(BOOL *restart, NSError *error, HTTPResponse *response) {
                   //NSLog(@"%@",response.responseJSON);
                   *restart = NO;
                   NSArray* resArray  = (NSArray *) response.responseJSON;
                   for (int i = 0; i<[resArray count]; i++) {
                       NSDictionary* prod = [resArray objectAtIndex:i];
                       *restart = *restart || ![[prod valueForKey:@"ready"] boolValue];
                       //NSLog(@"%hhd",[[prod valueForKey:@"ready"] boolValue]);
                       //NSLog(@"%hhd",*restart);
                       
                   }
                   
               }
            completionBlock: completionBlock];
    
}



-(void) getCheaperProduct {
    if (self.products == nil || self.products.count < 1 ) {
        //NSLog(@"Someething wrong with Product Array : %@",self.products);
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




-(NSDictionary *) getVersion: (NSDictionary *) prod {
    return [[prod objectForKey:@"versions"] objectAtIndex:0];
}


- (void) customBackButton {
    UIImage *backImage = [UIImage imageNamed:@"back-button"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0,0, backImage.size.width, backImage.size.height );
    [button setImage:backImage forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0,-10);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = item;
}

-(void) fakeProducts {
    
    NSError * localError = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"products" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //NSLog(@"data: %@", data);
    
    self.products = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &localError];
    if (localError == nil)
        NSLog(@"myConvertedJSONData: %@",@"here"); //, self.products);
    else {
        NSLog(@"json error: %@", [localError userInfo]);
    }
    
    self.product = [self.products objectAtIndex:0];
    //NSLog(@"product : %@", self.product);
    
}

- (void) comparePrices {
    //NSLog(@"Comparing Prices: %@", self.products);
    NSMutableArray *productsArray = [[NSMutableArray alloc] initWithArray:self.products];
    [productsArray sortUsingComparator:^NSComparisonResult(NSDictionary *product1, NSDictionary * product2){
        NSDictionary *version1 = [self getVersion:product1] ;
        NSDictionary *version2 = [self getVersion:product2];
        
        float totalPrice1 = [[version1 valueForKey:@"price_shipping"] floatValue] + [[version1 valueForKey:@"price"] floatValue] - [[version1 valueForKey:@"cashfront_value"] floatValue];
        
        float totalPrice2 = [[version2 valueForKey:@"price_shipping"] floatValue] + [[version2 valueForKey:@"price"] floatValue] - [[version2 valueForKey:@"cashfront_value"] floatValue];

        if ( totalPrice1 > totalPrice2) {
             return (NSComparisonResult)NSOrderedDescending;
         }
        
        if (totalPrice1 < totalPrice2) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        
         return (NSComparisonResult)NSOrderedSame;
     }];
    
    self.products = productsArray;
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
