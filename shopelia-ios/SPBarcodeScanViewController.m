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

#define PRODUCT_SEARCH_SEGUE_NAME @"SHOW_PRODUCT_SEARCH"

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
    
    // if we don't have a symbol data
    if (!symbol.data)
        return ;
    
    // vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    // fetch product
    [self performSegueWithIdentifier:PRODUCT_SEARCH_SEGUE_NAME sender:[symbol data]];
}

#pragma mark - Interface

- (void)setupUI
{
    [super setupUI];
    
    self.footerSeparatorView.backgroundColor = [SPVisualFactory navigationBarBackgroundColor];
    self.centerLabel.textColor = [SPVisualFactory navigationBarBackgroundColor];
    self.centerLabel.text = NSLocalizedString(@"CenterBarCodeInZone", nil);
    self.searchBar.placeholder = NSLocalizedString(@"SearchAProduct", nil);
    
    // configure search bar
    UIControl <UITextInputTraits> *subView = [self firstSubviewConformingToProtocol:@protocol(UITextInputTraits) inView:self.searchBar];
    [subView setKeyboardAppearance: UIKeyboardAppearanceAlert];
    [subView setReturnKeyType:UIReturnKeyDone];
}

- (id)firstSubviewConformingToProtocol:(Protocol *)pro inView:(UIView *)view
{
    if ([view conformsToProtocol: pro])
        return view;
    
    for (UIView *sub in view.subviews) {
        UIView *ret = [self firstSubviewConformingToProtocol:pro inView:sub];
        if (ret)
            return ret;
    }
    
    return nil;
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
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.readerView.readerDelegate = self;
    
    // configure zbar symbols
    [self.readerView.scanner setSymbology:0 config:ZBAR_CFG_ENABLE to:NO];
    [self.readerView.scanner setSymbology:ZBAR_UPCA config:ZBAR_CFG_ENABLE to:YES];
    [self.readerView.scanner setSymbology:ZBAR_UPCE config:ZBAR_CFG_ENABLE to:YES];
    [self.readerView.scanner setSymbology:ZBAR_EAN13 config:ZBAR_CFG_ENABLE to:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.readerView start];
    
    [self performSelector:@selector(test) withObject:nil afterDelay:1.0f];
}

- (void)test
{
     [self performSegueWithIdentifier:PRODUCT_SEARCH_SEGUE_NAME sender:@"4015672106192"];
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
