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
#import "loadingView.h"
#import "errorViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Constants.h"

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

    self.readerDelegate = self;
    self.supportedOrientationsMask = ZBarOrientationMaskAll;
    self.showsZBarControls = NO;
    self.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;

    self.wantsFullScreenLayout = NO;
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

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.readerView setFrameSizeWithW:self.view.bounds.size.width h:self.view.bounds.size.height - 90.0f];
    [self.cameraOverlayView setFrame:self.view.bounds];
    
    overlayView *view = (overlayView *)self.cameraOverlayView;
    CGFloat rectangleX = (self.readerView.frame.size.width - view.scanRectangleSize.width) / 2.0f;
    CGFloat rectangleY = (self.readerView.frame.size.height - view.scanRectangleSize.width) / 2.0f;
    CGFloat rectangleWidth = view.scanRectangleSize.width;
    CGFloat rectangleHeight = view.scanRectangleSize.width;
    
    [self.readerView setScanCrop:CGRectMake(rectangleX / self.readerView.frame.size.width,
                                            rectangleY / self.readerView.frame.size.height,
                                            rectangleWidth / self.readerView.frame.size.width,
                                            rectangleHeight / self.readerView.frame.size.height)];
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

    for (symbol in results) {
        break;
    }

    // vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    self.productVC = [[productListViewController alloc] initWithNibName:@"productListViewController" bundle:nil];
    self.productVC.eanData = symbol.data; 
    [self.navigationController pushViewController:self.productVC animated:YES];
}




@end
