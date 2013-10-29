//
//  SPProductSearchViewController.h
//  shopelia-ios
//
//  Created by Nicolas on 25/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPPopableViewController.h"

@interface SPProductSearchViewController : SPPopableViewController

@property (strong, nonatomic) NSString *barcode;
@property (assign, nonatomic) BOOL fromScanner;

@end
