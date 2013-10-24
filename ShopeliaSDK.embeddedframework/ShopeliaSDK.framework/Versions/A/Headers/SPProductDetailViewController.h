//
//  SPProductDetailViewController.h
//  ShopeliaSDK
//
//  Created by Nicolas on 03/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPViewController.h"
#import "SPViewContentSize.h"

@interface SPProductDetailViewController : SPViewController <SPViewContentSize>

@property (strong, nonatomic) SPProduct *product;

@end
