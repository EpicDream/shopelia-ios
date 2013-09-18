//
//  SPZBarReaderViewController.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/10/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "ZBarReaderViewController.h"
#import "SPHTTPClient.h"
#import "productViewController.h"

@interface SPZBarReaderViewController : ZBarReaderViewController <ZBarReaderDelegate>

@property (strong, nonatomic) SPHTTPClient *SPClient;
@property (strong,nonatomic) productViewController *productVC;

@end
