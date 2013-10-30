//
//  SPProductSearchInProgressCell.m
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPProductSearchInProgressCell.h"

@interface SPProductSearchInProgressCell ()
@property (weak, nonatomic) IBOutlet SPLabel *textLabel;
@end

@implementation SPProductSearchInProgressCell

#pragma mark - Customization

- (void)customize
{
    self.textLabel.text = NSLocalizedString(@"SearchingForPricesAndAvailabilities", nil);
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
