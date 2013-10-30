//
//  SPSearchInProgressView.m
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPSearchInProgressView.h"

@interface SPSearchInProgressView ()
@property (weak, nonatomic) IBOutlet SPLabel *searchLabel;
@end

@implementation SPSearchInProgressView

#pragma mark - Customization

- (void)customize
{
    [super customize];
    
    self.searchLabel.text = NSLocalizedString(@"ProductSearchInProgress", nil);
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
