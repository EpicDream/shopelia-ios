//
//  SPChatAPIClient.h
//  shopelia-ios
//
//  Created by Nicolas on 12/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatTextMessage.h"
#import "SPChatProductMessage.h"
#import "SPChatCollectionMessage.h"

#define kSPChatAPIClientNoID @0x0

#define SPChatAPIClientMessageListUpdatedNotification @"SPChatAPIClientMessageListUpdatedNotification"
#define SPChatAPIClientStateChangedNotification @"SPChatAPIClientStateChangedNotification"

typedef NS_ENUM(NSUInteger, SPChatState)
{
    SPChatStateAvailable = 0,
    SPChatStateSleeping
};

@interface SPChatAPIClient : SPAPIV1Client

- (NSArray *)allMessages;
- (void)fetchNewMessages;
- (void)sendTextMessage:(SPChatTextMessage *)message;
- (void)clearAllMessages;

- (SPChatState)chatState;
- (NSString *)chatStateMessage;

- (void)markMessageAsRead:(SPChatMessage *)message;
- (NSUInteger)unreadMessageCount;

@end
