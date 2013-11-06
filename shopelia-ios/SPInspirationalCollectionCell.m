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
@property (weak, nonatomic) IBOutlet SPImageView *cacheImageView;
@property (weak, nonatomic) IBOutlet UIView *darkView;
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
            self.collectionImageView.image = image;
        }
    }];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    self.darkView.hidden = !highlighted;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.darkView.hidden = YES;
}

#pragma mark - Lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.cacheImageView.image = [[UIImage imageNamed:@"card_background_cache.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
}

@end
