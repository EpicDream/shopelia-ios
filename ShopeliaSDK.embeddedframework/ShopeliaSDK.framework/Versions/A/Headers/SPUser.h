//
//  SPUser.h
//  ShopeliaSDK
//
//  Created by Nicolas on 19/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPModelObject.h"
#import "SPAddress.h"
#import "SPPaymentCard.h"

@interface SPUser : SPModelObject

// returns the default address
- (SPAddress *)defaultAddress;

// add an address
- (void)addAddress:(SPAddress *)address;

// returns the default payment card
- (SPPaymentCard *)defaultPaymentCard;

// adds a payment card
- (void)addPaymentCard:(SPPaymentCard *)card;

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *firstname;
@property (strong, nonatomic) NSString *lastname;
@property (strong, nonatomic) NSNumber *ID;
@property (assign, nonatomic) BOOL hasPassword;
@property (assign, nonatomic) BOOL hasPincode;
@property (strong, nonatomic) NSMutableArray *addresses; // of SPAddress
@property (strong, nonatomic) NSMutableArray *paymentCards; // of SPPaymentCard

@end