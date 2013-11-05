//
//  SPDataCache.m
//  shopelia-ios
//
//  Created by Nicolas on 05/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPDataCache.h"

@interface SPDataCache ()
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) unsigned long long maxBytesSize;
@property (strong, nonatomic) NSMutableDictionary *entries;
@end

@implementation SPDataCache

#pragma mark - Lazy instantiation

- (NSMutableDictionary *)entries
{
    if (!_entries)
    {
        [self loadEntriesFromDisk];
    }
    return _entries;
}

#pragma mark - Entries

- (void)loadEntriesFromDisk
{
    
}

- (void)saveEntriesToDisk
{
    for (SPDataCacheEntry *entry in self.entries)
    {
        
    }
}

#pragma mark - Lifecycle

- (id)initWithName:(NSString *)name maxBytesSize:(unsigned long long)size
{
    self = [super init];
    
    if (self)
    {
        self.name = name;
        self.maxBytesSize = size;
    }
    return self;
}

- (id)init
{
    return [self initWithName:@"default" maxBytesSize:5 * 1024 * 1024]; // 10 mb
}

@end
