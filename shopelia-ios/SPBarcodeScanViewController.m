//
//  SPBarcodeScanViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 24/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPBarcodeScanViewController.h"
#import "SPSearchBar.h"
#import "SPBarcodeOverlayView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SPBarcodeScanViewController () <ZBarReaderViewDelegate>
@property (weak, nonatomic) IBOutlet ZBarReaderView *readerView;
@property (weak, nonatomic) IBOutlet SPBarcodeOverlayView *readerOverlayView;
@property (weak, nonatomic) IBOutlet UIView *footerSeparatorView;
@property (weak, nonatomic) IBOutlet SPSearchBar *searchBar;
@property (weak, nonatomic) IBOutlet SPLabel *centerLabel;
@end

@implementation SPBarcodeScanViewController

#pragma mark - ZBarReaderViewDelegate delegate

- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    // fetch first symbol
    ZBarSymbol *symbol = nil;
    for (symbol in symbols)
        break;
    
    // if we don't have a symbol
    if (!symbol)
        return ;
    
    // vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    // fetch product
}

#pragma mark - Interface

- (void)setupUI
{
    [super setupUI];
    
    self.footerSeparatorView.backgroundColor = [SPVisualFactory navigationBarBackgroundColor];
    self.centerLabel.textColor = [SPVisualFactory navigationBarBackgroundColor];
    self.centerLabel.text = NSLocalizedString(@"CenterBarCodeInZone", nil);
    self.searchBar.placeholder = NSLocalizedString(@"SearchAProduct", nil);
    self.readerView.readerDelegate = self;
    
    // configure zbar symbols
    [self.readerView.scanner setSymbology:0 config:ZBAR_CFG_ENABLE to:NO];
    [self.readerView.scanner setSymbology:ZBAR_UPCA config:ZBAR_CFG_ENABLE to:YES];
    [self.readerView.scanner setSymbology:ZBAR_UPCE config:ZBAR_CFG_ENABLE to:YES];
    [self.readerView.scanner setSymbology:ZBAR_EAN13 config:ZBAR_CFG_ENABLE to:YES];
}

#pragma mark - View lifecycle

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.readerView start];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.readerView stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
