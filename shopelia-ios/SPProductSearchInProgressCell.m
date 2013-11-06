//
//  SPProductSearchInProgressCell.m
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPProductSearchInProgressCell.h"

@interface SPProductSearchInProgressCell ()

@end

@implementation SPProductSearchInProgressCell

#pragma mark - Customization

- (void)customize
{
    [super customize];
    
    self.textLabel.text = NSLocalizedString(@"SearchingForPricesAndAvailabilities", nil);
}

@end
