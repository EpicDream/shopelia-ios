//
//  SPAddress.h
//  ShopeliaSDK
//
//  Created by Nicolas on 18/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPModelObject.h"

@interface SPAddress : SPModelObject

// returns the country name from the receiver's country code
- (NSString *)countryName;

@property (strong, nonatomic) NSString *firstname;
@property (strong, nonatomic) NSString *lastname;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *complementaryAddress;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *countryCode;
@property (strong, nonatomic) NSString *postalCode;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSNumber *ID;
@property (assign, nonatomic, getter = isDefaultAddress) BOOL defaultAddress;

@end
