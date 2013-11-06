//
//  SPCollectionView.m
//  shopelia-ios
//
//  Created by Nicolas on 04/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPCollectionView.h"

@implementation SPCollectionView

#pragma mark - Lifecycle

- (void)initialize
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialize];
}

@end
