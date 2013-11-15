//
//  SPChatPushNotificationsStepsView.m
//  shopelia-ios
//
//  Created by Nicolas on 13/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatPushNotificationsStepsView.h"

@interface SPChatPushNotificationsStepsView ()
@property (weak, nonatomic) IBOutlet SPLabel *pushNotificationsLabel;
@end

@implementation SPChatPushNotificationsStepsView

#pragma mark - Customize

- (void)customize
{
    [super customize];
    
    self.pushNotificationsLabel.text = NSLocalizedString(@"PushNotificationsArentEnabled", nil);
}

@end
