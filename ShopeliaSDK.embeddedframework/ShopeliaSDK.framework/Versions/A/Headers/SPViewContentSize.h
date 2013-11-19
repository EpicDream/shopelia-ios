//
//  SPViewContentSize.h
//  ShopeliaSDK
//
//  Created by Nicolas on 06/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPViewContentSize <NSObject>

@optional
+ (CGSize)estimatedContentSize;
+ (CGSize)minimumContentSize;
+ (CGSize)maximumContentSize;
+ (CGSize)externalContentSize;

- (CGSize)estimatedContentSize;
- (CGSize)minimumContentSize;
- (CGSize)maximumContentSize;
- (CGSize)externalContentSize;

@end
