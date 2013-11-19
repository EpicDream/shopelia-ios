//
//  SPChatSenderCollectionMessageTableViewCell.m
//  shopelia-ios
//
//  Created by Nicolas on 15/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatSenderCollectionMessageTableViewCell.h"

@interface SPChatSenderCollectionMessageTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *cardImageView;
@property (strong, nonatomic) IBOutlet SPImageView *collectionImageView;
@property (strong, nonatomic) IBOutlet SPLabel *seeProductLabel;
@end

@implementation SPChatSenderCollectionMessageTableViewCell

#pragma mark - Cell

- (void)configureWithChatMessage:(id)message
{
    if ([message class] != [SPChatCollectionMessage class])
        return ;
    
    SPChatCollectionMessage *collectionMessage = (SPChatCollectionMessage *)message;
    [self.collectionImageView setAsynchImageWithURL:collectionMessage.collection.imageURL];
}

#pragma mark - Customize

- (void)customize
{
    [super customize];
    
    // background image
    UIEdgeInsets insets = UIEdgeInsetsMake(15.0f, 15.0f, 32.0f, 15.0f);
    UIImage *backgroundImage = [[UIImage imageNamed:@"search_collection_background.png"] resizableImageWithCapInsets:insets];
    self.cardImageView.image = backgroundImage;
    
    self.seeProductLabel.text = NSLocalizedString(@"SeeTheCollection", nil);
}

@end
