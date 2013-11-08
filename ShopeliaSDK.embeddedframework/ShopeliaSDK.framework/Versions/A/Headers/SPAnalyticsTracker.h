//
//  SPAnalyticsTracker.h
//  ShopeliaSDK
//
//  Created by Nicolas on 22/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPSingletonObject.h"

@interface SPAnalyticsTracker : SPSingletonObject

// flushes the tracker
- (void)flush;

// resets the tracker
- (void)reset;

@end
