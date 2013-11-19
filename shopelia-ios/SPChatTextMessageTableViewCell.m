//
//  SPChatTextMessageTableViewCell.m
//  shopelia-ios
//
//  Created by Nicolas on 14/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatTextMessageTableViewCell.h"

@interface SPChatTextMessageTableViewCell ()

@end

@implementation SPChatTextMessageTableViewCell

#pragma mark - Content size

+ (CGSize)estimatedContentSize
{
    return CGSizeMake(178.0f, 0.0f);
}

+ (CGSize)minimumContentSize
{
    return CGSizeMake(0.0f, 10.0f + 44.0f + 2.0f + 20.0f + 20.0f);
}

+ (CGSize)externalContentSize
{
    return CGSizeMake(0.0f, 10.0f + 20.0f);
}

+ (CGFloat)heightForMessage:(NSString *)message
{
    CGFloat minimumHeight = [[self class] minimumContentSize].height;
    CGFloat computedHeight = [SPFontTailor sizeForText:message
                                                 width:[[self class] estimatedContentSize].width
                                                  font:[[self class] messageLabelFont]].height;
    return MAX(minimumHeight, computedHeight + [[self class] externalContentSize].height);
}

#pragma mark - Cell

+ (UIFont *)messageLabelFont
{
    return [UIFont fontWithName:[SPVisualFactory lightFontName] size:14.0f];
}

- (void)configureWithChatMessage:(id)message
{
    if ([message class] != [SPChatTextMessage class])
        return ;
    
    SPChatTextMessage *textMessage = (SPChatTextMessage *)message;
    self.messageLabel.text = [textMessage message];
}

#pragma mark - Customize

- (void)customize
{
    [super customize];
    
    self.timeLabel.textColor = [SPVisualFactory greyTextColor];
}

@end
