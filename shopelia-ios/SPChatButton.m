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
@property (strong, nonatomic) UILabel *badgeCountLabel;
@end

@implementation SPChatButton

#pragma mark - Lazy instantiation

- (UILabel *)badgeCountLabel
{
    if (!_badgeCountLabel)
    {
        _badgeCountLabel = [[UILabel alloc] init];
        _badgeCountLabel.backgroundColor = [UIColor redColor];
        _badgeCountLabel.textColor = [UIColor whiteColor];
        _badgeCountLabel.font = [UIFont fontWithName:[SPVisualFactory lightFontName] size:14.0f];
        _badgeCountLabel.layer.cornerRadius = 8.0f;
        _badgeCountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeCountLabel;
}

#pragma mark - SPChatAPIClient notifications

- (void)chatAPIClientStateDidChange
{
    // update visual state
    [self updateToChatState:[[SPChatAPIClient sharedInstance] chatState]];
}

- (void)chatAPIClientMessageListUpdated
{
    // update badge count
    NSUInteger newBadgeCount = [[SPChatAPIClient sharedInstance] unreadMessageCount];
    NSUInteger oldBadgeCount = self.badgeCount;
    [self setBadgeCount:newBadgeCount];
    
    if (newBadgeCount > oldBadgeCount)
        [self shake];
}

#pragma mark - State

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

#pragma mark - Shake

- (void)shake
{
    CGFloat t = 3.0;
    CGAffineTransform leftQuake  = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0);
    CGAffineTransform rightQuake = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0);
    
    self.transform = leftQuake;
    [UIView beginAnimations:@"earthquake" context:NULL];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:4];
    [UIView setAnimationDuration:0.05f];
    [UIView setAnimationDidStopSelector:@selector(shakeEnded:finished:context:)];
    self.transform = rightQuake;
    [UIView commitAnimations];
}

- (void)shakeEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([finished boolValue])
        self.transform = CGAffineTransformIdentity;
}

#pragma mark - Badge count

- (void)setBadgeCount:(NSUInteger)badgeCount
{
    _badgeCount = badgeCount;
    
    [self updateBadgeCount];
}

- (void)updateBadgeCount
{
    self.badgeCountLabel.text = [NSString stringWithFormat:@"%u", self.badgeCount];
    self.badgeCountLabel.hidden = (self.badgeCount == 0);
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.badgeCountLabel sizeToFit];
    self.badgeCountLabel.frame = CGRectMake(self.bounds.size.width - (self.badgeCountLabel.bounds.size.width + 12.0f) - 5.0f,
                                            5.0f,
                                            self.badgeCountLabel.bounds.size.width + 12.0f,
                                            MAX(self.badgeCountLabel.bounds.size.height, 15.0f));
}

#pragma mark - Lifecycle

- (void)initialize
{
    [self addSubview:self.badgeCountLabel];
    
    // update badge count
    [self setBadgeCount:[[SPChatAPIClient sharedInstance] unreadMessageCount]];

    // update visual state
    [self updateToChatState:[[SPChatAPIClient sharedInstance] chatState]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatAPIClientStateDidChange) name:SPChatAPIClientStateChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatAPIClientMessageListUpdated) name:SPChatAPIClientMessageListUpdatedNotification object:nil];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPChatAPIClientMessageListUpdatedNotification object:nil];
}

@end
