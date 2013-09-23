//
//  HTTPPoller.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/16/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "HTTPRequest.h"
#import "HTTPResponse.h"

#define HTTPPollerDefaultMaxTime 20.0f
#define HTTPPollerDefaultRequestInterval 1.0f

@interface HTTPPoller : NSObject

// performs a poll request for a specified time
+ (void)pollRequest:(HTTPRequest *)request
            maxTime:(NSTimeInterval)pollingTime
    requestInterval:(NSTimeInterval)requestInterval
       restartBlock:(void (^)(BOOL *restart, NSError *error, id response))restartBlock
    completionBlock:(void (^)(BOOL timeout, NSError *error, id response))completionBlock;

@end