//
//  SPErrorMessageView.m
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPErrorMessageView.h"

@interface SPErrorMessageView()

@end

@implementation SPErrorMessageView

#pragma mark - Lifecycle

- (void)initialize
{
    [SPViewController customizeView:self];
    
    [self.actionButton setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateNormal];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialize];
}

@end
