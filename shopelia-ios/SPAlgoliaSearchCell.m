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
