//
//  SPAlgoliaSearchCell.m
//  shopelia-ios
//
//  Created by Nicolas on 29/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAlgoliaSearchCell.h"

@interface SPAlgoliaSearchCell ()
@property (weak, nonatomic) IBOutlet SPFieldImageView *fieldImageView;
@end

@implementation SPAlgoliaSearchCell

#pragma mark - Cell

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(6.0f, 6.0f, 6.0f, 6.0f);
    if (highlighted)
        self.fieldImageView.image = [[SPVisualFactory cachedImageNamed:@"shopelia_field_active.png"] resizableImageWithCapInsets:insets];
    else
        self.fieldImageView.image = [[SPVisualFactory cachedImageNamed:@"shopelia_field_normal.png"] resizableImageWithCapInsets:insets];
}

#pragma mark - Customization

- (void)customize
{
    
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
