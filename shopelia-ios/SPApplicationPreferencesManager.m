//
//  SPApplicationPreferencesManager.m
//  shopelia-ios
//
//  Created by Nicolas on 15/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPApplicationPreferencesManager.h"

@implementation SPApplicationPreferencesManager

#pragma mark - Preferences

-(NSString *)preferencesFilename
{
    return @"application";
}

- (unsigned long long)launchCount
{
    return [[self objectForKey:@"launch_count"] unsignedLongLongValue];
}

- (void)incrementLaunchCount
{
    NSNumber *launchCount = [self objectForKey:@"launch_count"];
    
    if (!launchCount)
        launchCount = @0;
    launchCount = [NSNumber numberWithLongLong:[launchCount unsignedLongLongValue] + 1];
    [self setObject:launchCount forKey:@"launch_count"];
}

@end
