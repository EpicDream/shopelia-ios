//
//  SPBarcodeScanViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 24/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "SPBarcodeScanViewController.h"
#import "SPBarcodeOverlayView.h"
#import "SPProductSearchViewController.h"
#import "SPAlgoliaSearchViewController.h"

#define PRODUCT_SEARCH_SEGUE_NAME @"SHOW_PRODUCT_SEARCH"

@interface SPBarcodeScanViewController () <ZBarReaderViewDelegate>
@property (weak, nonatomic) IBOutlet ZBarReaderView *readerView;
@property (weak, nonatomic) IBOutlet SPBarcodeOverlayView *readerOverlayView;
@property (weak, nonatomic) IBOutlet UIView *footerSeparatorView;
@property (weak, nonatomic) IBOutlet SPLabel *centerLabel;
@property (strong, nonatomic) NSString *lastBarcode;
@property (assign, nonatomic) BOOL lastBarcodeWasFromScanner;
@property (strong, nonatomic) SPAlgoliaSearchViewController *algoliaSearchViewController;
@end

@implementation SPBarcodeScanViewController

#pragma mark - Lazy instanciation

- (SPAlgoliaSearchViewController *)algoliaSearchViewController
{
    if (!_algoliaSearchViewController)
    {
        _algoliaSearchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SPAlgoliaSearchViewController"];
    }
    return _algoliaSearchViewController;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:PRODUCT_SEARCH_SEGUE_NAME])
    {
        SPProductSearchViewController *vc = (SPProductSearchViewController *)segue.destinationViewController;
        vc.barcode = self.lastBarcode;
        vc.fromScanner = self.lastBarcodeWasFromScanner;
    }
}

#pragma mark - ZBarReaderViewDelegate delegate

- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    // fetch first symbol
    ZBarSymbol *symbol = nil;
    for (symbol in symbols)
        break;
    
    // if we don't have a symbol data
    if (!symbol.data)
        return ;
    
    // vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    // fetch product
    self.lastBarcode = [symbol data];
    self.lastBarcodeWasFromScanner = YES;
    [self performSegueWithIdentifier:PRODUCT_SEARCH_SEGUE_NAME sender:self];
}

#pragma mark - Interface

- (void)setupUI
{
    [super setupUI];
    
    self.footerSeparatorView.backgroundColor = [SPVisualFactory navigationBarBackgroundColor];
    self.centerLabel.textColor = [SPVisualFactory navigationBarBackgroundColor];
    self.centerLabel.text = NSLocalizedString(@"CenterBarCodeInZone", nil);
    
    // add Algolia search view controller
    [self addChildViewController:self.algoliaSearchViewController];
    [self.view addSubview:self.algoliaSearchViewController.view];
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // compute scan crop
    CGFloat rectangleX = (self.readerView.frame.size.width - self.readerOverlayView.scanSize.width) / 2.0f;
    CGFloat rectangleY = (self.readerView.frame.size.height - self.readerOverlayView.scanSize.width) / 2.0f;
    CGFloat rectangleWidth = self.readerOverlayView.scanSize.width;
    CGFloat rectangleHeight = self.readerOverlayView.scanSize.width;
    
    [self.readerView setScanCrop:CGRectMake(rectangleX / self.readerView.frame.size.width,
                                            rectangleY / self.readerView.frame.size.height,
                                            rectangleWidth / self.readerView.frame.size.width,
                                            rectangleHeight / self.readerView.frame.size.height)];
    
    // resize algolia search view
    self.algoliaSearchViewController.view.frame = self.view.bounds;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.readerView.readerDelegate = self;
    
    // configure zbar symbols
    [self.readerView.scanner setSymbology:0 config:ZBAR_CFG_ENABLE to:NO];
    [self.readerView.scanner setSymbology:ZBAR_EAN13 config:ZBAR_CFG_ENABLE to:YES];
    [self.readerView setTrackingColor:[SPVisualFactory validColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.readerView performSelector:@selector(start) withObject:nil afterDelay:0.00f];
}

- (void)test
{
    self.lastBarcode = @"0609465362465";
    self.lastBarcodeWasFromScanner = YES;
    [self performSegueWithIdentifier:PRODUCT_SEARCH_SEGUE_NAME sender:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.readerView stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
