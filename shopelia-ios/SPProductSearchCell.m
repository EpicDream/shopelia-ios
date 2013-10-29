//
//  SPProductSearchCell.m
//  shopelia-ios
//
//  Created by Nicolas on 25/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPProductSearchCell.h"

@interface SPProductSearchCell ()

@end

@implementation SPProductSearchCell

#pragma mark - Cell

- (void)configureWithProduct:(SPProduct *)product;
{
    self.priceLabel.text = [product formattedTotalPrice];
    [self.merchantButton setTitle:[NSString stringWithFormat:NSLocalizedString(@"By%@", nil), product.merchant.domain] forState:UIControlStateNormal];
    [self.merchantButton setTitle:[self.merchantButton titleForState:UIControlStateNormal] forState:UIControlStateHighlighted];
    self.shippingInfoLabel.text = [product shippingInfo];
}

#pragma mark - Customization

- (void)customize
{
    self.priceLabel.textColor = [SPVisualFactory validColor];
    self.shippingPriceLabel.text = NSLocalizedString(@"IncludedDelivery", nil);
    [self.merchantButton setTitleColor:[SPVisualFactory linkTextColor] forState:UIControlStateNormal];
    [self.merchantButton setTitleColor:[SPColor darkerColorForColor:[SPVisualFactory linkTextColor]] forState:UIControlStateHighlighted];
    [[self.merchantButton titleLabel] setFont:[UIFont fontWithName:self.merchantButton.titleLabel.font.fontName size:10.0f]];
}

#pragma mark - Lifecycle

- (void)initialize
{
    [SPViewController customizeView:self];
    [SPViewController translateView:self];
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self initialize];
}

@end
