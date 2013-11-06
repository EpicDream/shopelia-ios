//
//  SPMessageView.m
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPMessageView.h"

@implementation SPMessageView

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
