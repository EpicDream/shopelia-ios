//
//  SPProductSearchViewController.h
//  shopelia-ios
//
//  Created by Nicolas on 25/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPContainerViewController.h"

@interface SPProductSearchViewController : SPContainerViewController

@property (strong, nonatomic) NSString *barcode;
@property (assign, nonatomic) BOOL fromScanner;

@end
