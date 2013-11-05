//
//  SPDataCache.h
//  shopelia-ios
//
//  Created by Nicolas on 05/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPDataCacheEntry.h"

@interface SPDataCache : NSObject

- (id)initWithName:(NSString *)name maxBytesSize:(unsigned long long)size;

@end
