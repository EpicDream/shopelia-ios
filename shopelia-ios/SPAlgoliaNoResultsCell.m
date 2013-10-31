//
//  SPAlgoliaNoResultsCell.m
//  shopelia-ios
//
//  Created by Nicolas on 30/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAlgoliaNoResultsCell.h"

@interface SPAlgoliaNoResultsCell ()
@property (weak, nonatomic) IBOutlet SPLabel *noResultsLabel;
@end

@implementation SPAlgoliaNoResultsCell

#pragma mark - Customization

- (void)customize
{
    self.noResultsLabel.text = NSLocalizedString(@"NoResultsForThisQuery", nil);
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
