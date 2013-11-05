//
//  SPInspirationalCollectionCell.m
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPInspirationalCollectionCell.h"

@interface SPInspirationalCollectionCell ()
@property (weak, nonatomic) IBOutlet SPImageView *collectionImageView;
@end

@implementation SPInspirationalCollectionCell

- (void)configureWithInspirationalCollection:(SPInspirationalCollection *)collection
{
    [self.collectionImageView setAsynchImageWithURL:collection.imageURL];
}

@end
