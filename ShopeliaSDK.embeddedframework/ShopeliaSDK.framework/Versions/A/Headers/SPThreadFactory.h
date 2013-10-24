//
//  SPThreadFactory.h
//  ShopeliaSDK
//
//  Created by Nicolas on 13/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPStaticFlush.h"

@interface SPThreadFactory : NSObject <SPStaticFlush>

// returns the main dispatch queue
+ (dispatch_queue_t)mainDispatchQueue;

// returns the dispatch queue used to download images in background
+ (dispatch_queue_t)backgroundImagesDispatchQueue;

@end
