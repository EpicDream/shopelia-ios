//
//  threadFactory.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/16/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "threadFactory.h"

@implementation threadFactory

+ (dispatch_queue_t)mainDispatchQueue
{
    return dispatch_get_main_queue();
}

+ (dispatch_queue_t)backgroundImagesDispatchQueue
{
    static dispatch_queue_t queue = NULL;
    
    if (queue == NULL)
    {
        queue = dispatch_queue_create([[@"com.shopelia.sdk.ios" stringByAppendingString:@".background_images"] UTF8String], NULL);
    }
    return queue;
}

@end
