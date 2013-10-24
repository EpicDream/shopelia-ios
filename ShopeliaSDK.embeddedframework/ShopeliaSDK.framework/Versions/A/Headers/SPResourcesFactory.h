//
//  SPResourcesFactory.h
//  ShopeliaSDK
//
//  Created by Nicolas on 05/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPResourcesFactory : NSObject

// returns the path for a given resource name and type in the SPResourcesBundle
+ (NSString *)pathForResourceNamed:(NSString *)name ofType:(NSString *)type;

// returns the data of the file for a given name and type in the SPResourcesBundle
+ (NSData *)dataForResourceNamed:(NSString *)name ofType:(NSString *)type;

// returns the UIImage with the given name (screen scale aware) in the SPResourcesBundle
+ (UIImage *)imageNamed:(NSString *)name;

@end
