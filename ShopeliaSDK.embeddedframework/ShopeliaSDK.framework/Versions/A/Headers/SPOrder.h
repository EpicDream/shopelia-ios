//
//  SPOrder.h
//  ShopeliaSDK
//
//  Created by Nicolas on 02/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPProduct.h"
#import "SPAddress.h"
#import "SPPaymentCard.h"

@interface SPOrder : NSObject

// returns the most representative product
- (SPProduct *)representativeProduct;

// sets the representative product
- (void)setRepresentativeProduct:(SPProduct *)product;

// adds a product to the order
- (void)addProduct:(SPProduct *)product;

// returns the order total amount (sum of products total prices)
- (NSDecimalNumber *)totalAmount;

// returns the order expected total amount (sum of products expected total prices)
- (NSDecimalNumber *)expectedTotalAmount;

// returns the expected cash front value (sum of products cash front values)
- (NSDecimalNumber *)expectedCashFrontValue;

// returns the expected cash front value (sum of products shipping prices)
- (NSDecimalNumber *)expectedShippingPrice;

// returns the expected cash front value (sum of products prices)
- (NSDecimalNumber *)expectedProductPrice;

// returns the string formatted order total amount
- (NSString *)formattedTotalAmount;

@property (strong, nonatomic) SPAddress *address;
@property (strong, nonatomic) SPPaymentCard *paymentCard;

@end
