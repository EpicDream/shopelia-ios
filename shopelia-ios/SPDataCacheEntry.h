//
//  SPDataCacheEntry.h
//  shopelia-ios
//
//  Created by Nicolas on 05/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPDataCacheEntry : SPModelObject

@property (strong, nonatomic) NSData *data;
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSDate *lastUsageDate;

@end
