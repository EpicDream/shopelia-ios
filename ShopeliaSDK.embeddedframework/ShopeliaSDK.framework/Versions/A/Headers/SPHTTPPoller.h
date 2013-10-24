//
//  SPHTTPPoller.h
//  ShopeliaSDK
//
//  Created by Nicolas on 13/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPHTTPRequest.h"
#import "SPHTTPResponse.h"

#define SPHTTPPollerDefaultMaxTime 20.0f
#define SPHTTPPollerDefaultRequestInterval 1.0f

@interface SPHTTPPoller : NSObject

// performs a poll request for a specified time
+ (void)pollRequest:(SPHTTPRequest *)request
       maxTime:(NSTimeInterval)pollingTime
   requestInterval:(NSTimeInterval)requestInterval
      restartBlock:(void (^)(BOOL *restart, id response))restartBlock
   completionBlock:(void (^)(BOOL timeout, NSError *error, id response))completionBlock;

@end
