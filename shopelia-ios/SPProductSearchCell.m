//
//  SPProductSearchCell.m
//  shopelia-ios
//
//  Created by Nicolas on 25/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPProductSearchCell.h"

@implementation SPProductSearchCell

#pragma mark - Customization

- (void)customize
{
    self.priceLabel.textColor = [SPVisualFactory validColor];
}

#pragma mark - Lifecycle

- (void)initialize
{
    [SPViewController customizeView:self];
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self initialize];
}

@end
