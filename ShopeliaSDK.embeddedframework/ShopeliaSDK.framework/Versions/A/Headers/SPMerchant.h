//
//  SPMerchant.h
//  ShopeliaSDK
//
//  Created by Nicolas on 03/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPModelObject.h"

@interface SPMerchant : SPModelObject

@property (assign, nonatomic, getter = isAcceptingOrders) BOOL acceptsOrders;
@property (assign, nonatomic, getter = isAllowingIframe) BOOL allowsIframe;
@property (assign, nonatomic, getter = isAllowingQuantities) BOOL allowsQuantities;
@property (strong, nonatomic) NSNumber *ID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *URL;
@property (strong, nonatomic) NSURL *logoURL;
@property (strong, nonatomic) NSString *domain;
@property (strong, nonatomic) NSURL *termsAndConditionsURL;

@end
