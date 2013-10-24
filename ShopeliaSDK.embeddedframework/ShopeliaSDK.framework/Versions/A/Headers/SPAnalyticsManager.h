//
//  SPAnalyticsManager.h
//  ShopeliaSDK
//
//  Created by Nicolas on 22/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPSingletonObject.h"

@interface SPAnalyticsManager : SPSingletonObject

// tracks an "OK" event
- (void)trackOK:(NSString *)name;

// tracks an "in" event
- (void)trackIn:(NSString *)name;

// tracks a "display" event
- (void)trackDisplay:(NSString *)name;

// flushes the manager
- (void)flush;

// resets the manager
- (void)reset;

@end
