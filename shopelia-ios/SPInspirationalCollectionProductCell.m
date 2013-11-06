//
//  SPInspirationalCollectionProductCell.m
//  shopelia-ios
//
//  Created by Nicolas on 04/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPInspirationalCollectionProductCell.h"

@interface SPInspirationalCollectionProductCell ()
@property (weak, nonatomic) IBOutlet SPImageView *cardImageView;
@property (weak, nonatomic) IBOutlet SPButton *buyButton;
@property (weak, nonatomic) IBOutlet SPLabel *priceLabel;
@property (weak, nonatomic) IBOutlet SPImageView *productImageView;

@end

@implementation SPInspirationalCollectionProductCell

#pragma mark - Cell

- (void)configureWithProduct:(SPProduct *)product
{
    self.priceLabel.text = [product formattedRoundedTotalPrice];
    self.productImageView.image = nil;
    [self.productImageView setAsynchImageWithURL:product.imageURL];
}

#pragma mark - Customization

- (void)customize
{
    [super customize];
    
    // background image
    UIEdgeInsets insets = UIEdgeInsetsMake(10.0f, 10.0f, 32.0f, 10.0f);
    UIImage *backgroundImage = [[UIImage imageNamed:@"search_product_background.png"] resizableImageWithCapInsets:insets];
    self.cardImageView.image = backgroundImage;
    
    // price label
    self.priceLabel.textColor = [SPVisualFactory validColor];
    self.priceLabel.highlightedTextColor = self.priceLabel.textColor;
    self.priceLabel.font = [UIFont fontWithName:[SPVisualFactory regularFontName] size:14.0f];
    
    // buy button
    [self.buyButton.titleLabel setFont:[UIFont fontWithName:[SPVisualFactory lightFontName] size:14.0f]];
    [self.buyButton setTitle:NSLocalizedString(@"Buy", nil) forState:UIControlStateNormal];
    [self.buyButton.titleLabel setHighlightedTextColor:self.buyButton.titleLabel.textColor];
}

@end
