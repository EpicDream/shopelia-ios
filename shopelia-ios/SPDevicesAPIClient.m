//
//  SPDevicesAPIClient.m
//  shopelia-ios
//
//  Created by Nicolas on 13/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPDevicesAPIClient.h"
#import "SPPushNotificationsPreferencesManager.h"

@interface SPDevicesAPIClient ()
@property (strong, nonatomic) SPAPIRequest *deviceTokenRequest;
@end

@implementation SPDevicesAPIClient

- (void)handleNewDeviceToken:(NSData *)token
{
    NSData *lastSentToken = [[SPPushNotificationsPreferencesManager sharedInstance] deviceToken];
    
    if (![token isEqualToData:lastSentToken])
    {
        // cancel current request
        [self.deviceTokenRequest cancelAndClearCompletionBlock];
        
        // create request
        self.deviceTokenRequest = [self defaultRequest];
        NSString *currentUUID = [SPUUIDManager sharedUUID];
        NSString *pushToken = @"";
        NSURL *requestURL = [[self.baseURL URLByAppendingPathComponent:@"api/devices"] URLByAppendingPathComponent:currentUUID];
        [self.deviceTokenRequest setHTTPMethod:@"PUT"];
        [self.deviceTokenRequest setURL:requestURL];
        [self.deviceTokenRequest setHTTPBodyParameters:@{@"device" : @{@"push_token" : pushToken}}];
        [self.deviceTokenRequest startWithCompletion:^(NSError *error, SPAPIResponse *response) {
            if (error || [response statusCode] != 204)
            {
                [self.deviceTokenRequest performSelector:@selector(start) withObject:nil afterDelay:1.0f];
            }
            else
            {
                [[SPPushNotificationsPreferencesManager sharedInstance] setDeviceToken:token];
            }
        }];
    }
}

@end
