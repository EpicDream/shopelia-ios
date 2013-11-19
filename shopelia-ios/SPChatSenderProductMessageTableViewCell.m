//
//  SPChatSenderProductMessageTableViewCell.m
//  shopelia-ios
//
//  Created by Nicolas on 15/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatSenderProductMessageTableViewCell.h"

@interface SPChatSenderProductMessageTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *cardImageView;
@property (strong, nonatomic) IBOutlet SPImageView *productImageView;
@property (strong, nonatomic) IBOutlet SPLabel *seeProductLabel;
@end

@implementation SPChatSenderProductMessageTableViewCell

#pragma mark - Cell

- (void)configureWithChatMessage:(id)message
{
    if ([message class] != [SPChatProductMessage class])
        return ;
    
    SPChatProductMessage *productMessage = (SPChatProductMessage *)message;
    [self.productImageView setAsynchImageWithURL:productMessage.imageURL];
}

#pragma mark - Customize

- (void)customize
{
    [super customize];
    
    // background image
    UIEdgeInsets insets = UIEdgeInsetsMake(10.0f, 10.0f, 32.0f, 10.0f);
    UIImage *backgroundImage = [[UIImage imageNamed:@"search_product_background.png"] resizableImageWithCapInsets:insets];
    self.cardImageView.image = backgroundImage;
    
    self.seeProductLabel.text = NSLocalizedString(@"SeeTheProduct", nil);
}

@end
