//
//  SPZBarReaderViewController.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/10/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "SPZBarReaderViewController.h"
#import "overlayView.h"
#import "UIView+Shopelia.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO( v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface SPZBarReaderViewController ()

@end

@implementation SPZBarReaderViewController

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
    NSLog(@"%@",UIScreen.mainScreen);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
