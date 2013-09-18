//
//  SPThreadFactory.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/16/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPThreadFactory : NSObject

+ (dispatch_queue_t)mainDispatchQueue;
+ (dispatch_queue_t)backgroundImagesDispatchQueue;

@end
