//
//  SPChatButton.m
//  shopelia-ios
//
//  Created by Nicolas on 19/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatButton.h"
#import "SPChatAPIClient.h"

@interface SPChatButton ()

@end

@implementation SPChatButton

#pragma mark - SPChatAPIClient notifications

- (void)chatAPIClientStateDidChange
{
    // update visual state
    [self updateToChatState:[[SPChatAPIClient sharedInstance] chatState]];
}

#pragma mark - Button

- (void)updateToChatState:(SPChatState)chatState
{
    if (chatState == SPChatStateSleeping)
    {
        [self setImage:[UIImage imageNamed:@"btn_chat_sleep_normal.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"btn_chat_sleep_normal.png"] forState:UIControlStateHighlighted];
    }
    else
    {
        [self setImage:[UIImage imageNamed:@"btn_chat_available_normal.png"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"btn_chat_available_hover.png"] forState:UIControlStateHighlighted];
    }
}

#pragma mark - Lifecycle

- (void)initialize
{
    // update visual state
    [self updateToChatState:[[SPChatAPIClient sharedInstance] chatState]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatAPIClientStateDidChange) name:SPChatAPIClientStateChangedNotification object:nil];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialize];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPChatAPIClientStateChangedNotification object:nil];
}

@end
