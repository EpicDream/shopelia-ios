//
//  SPProductVersion.h
//  ShopeliaSDK
//
//  Created by Nicolas on 03/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPModelObject.h"
#import "SPProductOptionValue.h"

@interface SPProductVersion : SPModelObject

// returns all the options
- (NSArray *)allOptions; // of SPProductOptionValue

// returns a version hash given an option value array
+ (NSUInteger)hashForOptionValues:(NSArray *)optionValues;

@property (strong, nonatomic) NSString *availabilityInfo;
@property (assign, nonatomic, getter = isAvailable) BOOL available;
@property (strong, nonatomic) NSDecimalNumber *cashFrontValue;
@property (strong, nonatomic) NSDecimalNumber *price;
@property (strong, nonatomic) NSDecimalNumber *strikeoutPrice;
@property (strong, nonatomic) NSDecimalNumber *shippingPrice;
@property (strong, nonatomic) NSString *shippingInfo;
@property (strong, nonatomic) NSURL *imageURL;
@property (assign, nonatomic) CGSize imageSize;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *ID;
@property (strong, nonatomic) NSString *definition;

@end
