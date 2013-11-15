//
//  SPChatTextMessageTableViewCell.h
//  shopelia-ios
//
//  Created by Nicolas on 14/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatMessageTableViewCell.h"
#import "SPChatTextMessage.h"

@interface SPChatTextMessageTableViewCell : SPChatMessageTableViewCell

@property (weak, nonatomic) IBOutlet SPLabel *messageLabel;
@property (weak, nonatomic) IBOutlet SPLabel *timeLabel;
@property (weak, nonatomic) IBOutlet SPLabel *senderLabel;

@end
