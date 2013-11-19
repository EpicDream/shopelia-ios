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

- (id)initWithName:(NSString *)name rootDirectoryName:(NSString *)root maxCacheSize:(unsigned long long)size;
- (NSData *)dataForKey:(NSString *)key;
- (SPDataCacheEntry *)entryForKey:(NSString *)key;
- (SPDataCacheEntry *)setData:(NSData *)data forKey:(NSString *)key;

@property (strong, nonatomic) NSString *versionString;
@property (strong, nonatomic) NSString *buildNumberString;

@end
