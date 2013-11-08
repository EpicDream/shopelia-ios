//
//  SPSDKAnalyticsTracker.h
//  ShopeliaSDK
//
//  Created by Nicolas on 08/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAnalyticsTracker.h"

@interface SPSDKAnalyticsTracker : SPAnalyticsTracker

// tracks an "Click On" event
- (void)trackClickOn:(NSString *)name;

// tracks an "OK" event
- (void)trackOK:(NSString *)name;

// tracks an "In" event
- (void)trackIn:(NSString *)name;

// tracks a "Display" event
- (void)trackDisplay:(NSString *)name;


@end
