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

#pragma mark - Cell

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
