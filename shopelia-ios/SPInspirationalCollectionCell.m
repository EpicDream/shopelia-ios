//
//  SPInspirationalCollectionCell.m
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPInspirationalCollectionCell.h"
#import "SPImageProcessor.h"

@interface SPInspirationalCollectionCell ()
@property (weak, nonatomic) IBOutlet SPImageView *collectionImageView;
@property (weak, nonatomic) IBOutlet UIView *collectionContainerView;
@property (strong, nonatomic) SPInspirationalCollection *collection;
@end

@implementation SPInspirationalCollectionCell

#pragma mark - Cell

- (void)configureWithInspirationalCollection:(SPInspirationalCollection *)collection
{
    self.collection = collection;
    
    // fetch image
    self.collectionImageView.image = nil;
    [[SPRemoteImageLoader sharedInstance] fetchImageForURL:collection.imageURL completion:^(NSURL *imageURL, UIImage *image) {
        if ([self.collection.imageURL isEqual:imageURL])
        {
            self.collectionImageView.image = image;//[SPImageProcessor cardImage:image];
        }
    }];
}

#pragma mark - Lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CGFloat cornerRadius = 1.5f;
    self.collectionContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.collectionContainerView.layer.shadowOffset = CGSizeMake(0, 1);
    self.collectionContainerView.layer.shadowOpacity = 0.4f;
    self.collectionContainerView.layer.shadowRadius = 0.5f;
    self.collectionContainerView.layer.masksToBounds = NO;
    self.collectionContainerView.layer.cornerRadius = cornerRadius;
    self.collectionImageView.layer.cornerRadius = cornerRadius;
    self.collectionContainerView.layer.shouldRasterize = YES;
    self.collectionContainerView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

@end
