//
//  SPChatSenderProductMessageTableViewCell.m
//  shopelia-ios
//
//  Created by Nicolas on 15/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatSenderProductMessageTableViewCell.h"

@implementation SPChatSenderProductMessageTableViewCell

#pragma mark - Cell

- (void)configureWithChatMessage:(id)message
{
    if ([message class] != [SPChatProductMessage class])
        return ;
    
    SPChatProductMessage *productMessage = (SPChatProductMessage *)message;
    
}

@end
