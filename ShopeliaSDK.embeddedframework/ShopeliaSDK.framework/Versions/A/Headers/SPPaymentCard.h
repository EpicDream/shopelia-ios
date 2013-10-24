//
//  SPPaymentCard.h
//  ShopeliaSDK
//
//  Created by Nicolas on 19/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPModelObject.h"

@interface SPPaymentCard : SPModelObject

// returns the secured number string
- (NSString *)securedNumberString;

@property (strong, nonatomic) NSNumber *ID;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *expiryMonth;
@property (strong, nonatomic) NSString *expiryYear;
@property (strong, nonatomic) NSString *CVV;

@end
