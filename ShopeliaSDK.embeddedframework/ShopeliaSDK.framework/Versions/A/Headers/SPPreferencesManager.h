//
//  SPPreferencesManager.h
//  ShopeliaSDK
//
//  Created by Nicolas on 12/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPSingletonObject.h"

@interface SPPreferencesManager : SPSingletonObject

- (NSString *)preferencesRootDirectory;
- (NSString *)preferencesFilename;
- (NSString *)preferencesDirectory;
- (NSString *)preferencesExtension;
- (NSString *)preferencesFilepath;

- (void)markItemAsExcludedFromCloudBackup:(NSString *)filepath;

- (void)loadPreferences;
- (void)writePreferences;

- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

@end
