//
//  SPZBarReaderViewController.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/10/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "SPZBarReaderViewController.h"
#import "HTTPRequest.h"
#import "overlayView.h"
#import "UIView+Shopelia.h"
#import "imageView.h"


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO( v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface SPZBarReaderViewController ()

@end

@implementation SPZBarReaderViewController

@synthesize SPClient;

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
    [super viewDidLoad]; // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *logo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"logo-word.png" ]];
    self.navigationItem.titleView = logo ;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.readerDelegate = self;
    self.supportedOrientationsMask = ZBarOrientationMaskAll;
    self.showsZBarControls = NO;

    [self.readerView setFrameSizeWithW:UIScreen.mainScreen.bounds.size.width h:UIScreen.mainScreen.bounds.size.height];

    self.wantsFullScreenLayout = NO;
    //NSLog(@"%@",UIScreen.mainScreen);
    overlayView *view = [[overlayView alloc] initWithFrame:self.readerView.frame];
    self.cameraOverlayView = view;
    //self.scanCrop = CGRectMake(0,0,0.5,0.5);


    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [self.scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];

	// Do any additional setup after loading the view.
    
   }


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    overlayView *view = (overlayView *)self.cameraOverlayView;
    CGFloat x,y,width,height;
    
    x = view.scanCrop.origin.y / self.readerView.bounds.size.width;
    y = view.scanCrop.origin.x / self.readerView.bounds.size.height;
    width = view.scanCrop.size.height / self.readerView.bounds.size.width;
    height = view.scanCrop.size.width / self.readerView.bounds.size.height;
    
    
    self.readerView.scanCrop = CGRectMake(x,y,width,height);
    //NSLog(@"%@",view.scanCrop);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma Zbar Delegate Implementation

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    [self getProductNameAndUrlsWithEAN: symbol.data];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissViewControllerAnimated:YES completion:nil];
}


- (void) getProductNameAndUrlsWithEAN: (NSString *) EAN {
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    NSString *shopeliApiKey = [dict valueForKey:@"ShopeliaAPIKey"] ;
    
    NSString *url = API_URL;
    url =[url stringByAppendingFormat:@"showcase/products/search?ean=%@&visitor=%@",EAN,@"false"];

    HTTPRequest *request = [[HTTPRequest alloc] init];
    [request setValue:shopeliApiKey forHTTPHeaderField:@"X-Shopelia-ApiKey"];
    
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    [request startWithCompletion:^(NSError *error, HTTPResponse *response){
        if (error == nil) {
            ////NSLog(@"%@",response.responseJSON);
            NSMutableArray *urls = [response.responseJSON objectForKey:@"urls"];
            ////NSLog(@"%@",urls);
            if (urls != nil) {
                //self.productVC = [[productViewController alloc] initWithNibName:@"productViewController" bundle:nil];
                self.productVC = [[productListViewController alloc] initWithNibName:@"productListViewController" bundle:nil];
                self.productVC.product = response.responseJSON;
                self.productVC.urls = urls;
                [self.navigationController pushViewController:self.productVC animated:YES];
            }
        } else {
            //NSLog(@"%@",error);
        }
    }];
 
}


@end
