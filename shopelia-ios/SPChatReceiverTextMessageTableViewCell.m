//
//  SPChatReceiverTextMessageTableViewCell.m
//  shopelia-ios
//
//  Created by Nicolas on 14/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatReceiverTextMessageTableViewCell.h"

@implementation SPChatReceiverTextMessageTableViewCell

#pragma mark - Customize

- (void)customize
{
    [super customize];
    
    self.senderLabel.textColor = [SPVisualFactory greyTextColor];
    self.senderLabel.text = NSLocalizedString(@"You", nil);
}

@end
