//
//  SPChatConversationViewController.h
//  shopelia-ios
//
//  Created by Nicolas on 12/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPContainerViewController.h"

@class SPChatConversationViewController;

@protocol SPChatConversationViewControllerDelegate <NSObject>

- (void)chatConversationViewControllerDidEndConversation:(SPChatConversationViewController *)vc;

@end

@interface SPChatConversationViewController : SPContainerViewController

+ (void)showChatConversation:(BOOL)force;

@property (weak, nonatomic) id <SPChatConversationViewControllerDelegate> delegate;

@end
