//
//  SPChatSenderTextMessageTableViewCell.m
//  shopelia-ios
//
//  Created by Nicolas on 14/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatSenderTextMessageTableViewCell.h"

@implementation SPChatSenderTextMessageTableViewCell

#pragma mark - Customize

- (void)customize
{
    [super customize];

    self.senderLabel.textColor = [SPVisualFactory navigationBarBackgroundColor];
    self.senderLabel.text = NSLocalizedString(@"George", nil);
}

@end
