//
//  HTTPPoller.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/16/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "HTTPPoller.h"


@implementation HTTPPoller

#pragma mark - Request management

+ (void)launchRequest:(HTTPRequest *)request
{
    [request start];
}

+ (void)pollRequest:(HTTPRequest *)request
            maxTime:(NSTimeInterval)pollingTime
    requestInterval:(NSTimeInterval)requestInterval
       restartBlock:(void (^)(BOOL *restart, NSError *error, id response))restartBlock
    completionBlock:(void (^)(BOOL timeout, NSError *error, id response))completionBlock
{
    __block NSDate *startTime = nil;
    __weak HTTPRequest *weakRequest = request;
    
    // setup request
    [request setTimeoutInterval:[NSNumber numberWithDouble:pollingTime]];
    
    // request completion block
    [request setCompletionBlock:^(NSError *error, id response) {
        
        // do we need to restart?
        BOOL wantsToRestart = NO;
        if (restartBlock)
            restartBlock(&wantsToRestart, error, response);
        
        // we need to restart
        if (wantsToRestart == YES)
        {
            NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:startTime];
            if (interval < pollingTime)
            {
                [self performSelector:@selector(launchRequest:) withObject:weakRequest afterDelay:requestInterval];
            }
            else if (completionBlock)
            {
                completionBlock(YES, nil, nil);
            }
        }
        else if (completionBlock)
        {
            completionBlock(NO, error, response);
        }
    }];
    
    // start request
    startTime = [NSDate date];
    [self launchRequest:request];
}

@end