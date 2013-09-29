//
//  SPZBarReaderViewController.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/10/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "ZBarReaderViewController.h"
#import "HTTPClient.h"
#import "productViewController.h"
#import "productListViewController.h"


@interface SPZBarReaderViewController : ZBarReaderViewController <ZBarReaderDelegate>

@property (strong, nonatomic) HTTPClient *SPClient;
//@property (strong,nonatomic) productViewController *productVC;
@property (strong,nonatomic) productListViewController *productVC;


@end
