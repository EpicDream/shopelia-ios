//
//  SPProductSearchCell.h
//  shopelia-ios
//
//  Created by Nicolas on 25/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPTableViewCell.h"

@interface SPProductSearchCell : SPTableViewCell <SPViewCustomization>

@property (weak, nonatomic) IBOutlet SPLabel *priceLabel;
@property (weak, nonatomic) IBOutlet SPLabel *shippingInfoLabel;

@end
