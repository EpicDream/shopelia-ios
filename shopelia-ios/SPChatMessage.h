//
//  SPChatMessage.h
//  shopelia-ios
//
//  Created by Nicolas on 14/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

typedef enum NSUInteger
{
    SPChatMessageDeliveryStatusSending = 1 << 0,
    SPChatMessageDeliveryStatusSent = 1 << 1,
    SPChatMessageDeliveryStatusRead = 1 << 3
} SPChatMessageStatus;

@interface SPChatMessage : SPModelObject

- (BOOL)statusState:(SPChatMessageStatus)status;
- (void)setStatus:(SPChatMessageStatus)status state:(BOOL)enabled;
- (NSString *)displayCellIdentifier;

@property (strong, nonatomic) NSNumber *ID;
@property (assign, nonatomic) BOOL fromAgent;
@property (assign, nonatomic) SPChatMessageStatus messageStatus;
@property (strong, nonatomic) NSNumber *timestamp;

@end
