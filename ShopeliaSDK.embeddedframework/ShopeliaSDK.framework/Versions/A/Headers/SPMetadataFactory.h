//
//  SPMetadataFactory.h
//  shopelia-ios
//
//  Created by Nicolas on 05/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPMetadataFactory : NSObject

+ (NSString *)bundleIdentifier:(NSBundle *)bundle;
+ (NSString *)bundleVersionString:(NSBundle *)bundle;
+ (NSString *)bundleBuildNumberString:(NSBundle *)bundle;

@end
