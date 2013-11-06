//
//  SPDataCacheEntry.h
//  shopelia-ios
//
//  Created by Nicolas on 05/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPModelObject.h"

@interface SPDataCacheEntry : SPModelObject

@property (strong, nonatomic) NSString *versionString;
@property (strong, nonatomic) NSString *buildNumberString;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSNumber *lastUsageTimestamp;
@property (strong, nonatomic) NSNumber *filesize;

@end
