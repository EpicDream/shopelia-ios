//
//  SPGeorgeConversationViewController.h
//  shopelia-ios
//
//  Created by Nicolas on 12/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPContainerViewController.h"

@class SPGeorgeConversationViewController;

@protocol SPGeorgeConversationViewControllerDelegate <NSObject>

- (void)georgeConversationViewControllerDidEndConversation:(SPGeorgeConversationViewController *)vc;

@end

@interface SPGeorgeConversationViewController : SPContainerViewController

@property (weak, nonatomic) id <SPGeorgeConversationViewControllerDelegate> delegate;

@end
