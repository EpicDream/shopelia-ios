//
//  SPProductSearchInProgressCell.h
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPTableViewCell.h"
#import "SPShopeliaSpinnerView.h"

@interface SPProductSearchInProgressCell : SPTableViewCell

@property (weak, nonatomic) IBOutlet SPLabel *textLabel;
@property (weak, nonatomic) IBOutlet SPShopeliaSpinnerView *spinner;

@end
