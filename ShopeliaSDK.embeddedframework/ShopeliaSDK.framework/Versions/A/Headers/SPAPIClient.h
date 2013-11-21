//
//  SPAPIClient.h
//  ShopeliaSDK
//
//  Created by Nicolas on 04/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPHTTPClient.h"
#import "SPAPIRequest.h"
#import "SPAPIResponse.h"
#import "SPAPIError.h"
#import "SPProduct.h"
#import "SPMerchant.h"
#import "SPSession.h"
#import "SPPaymentCard.h"
#import "SPOrder.h"

#define SPAuthTokenHeaderKey @"X-Shopelia-AuthToken"
#define SPAPIKeyHeaderKey @"X-Shopelia-ApiKey"

@interface SPAPIClient : SPHTTPClient

// returns the API user agent used in requests header
- (NSString *)APIUserAgent;

// fetches a product's merchant
- (SPAPIRequest *)fetchProductMerchant:(SPProduct *)product completion:(void (^)(SPAPIError *error, SPMerchant *merchant))completion;

// registers a new user
- (SPAPIRequest *)registerUser:(SPUser *)user tracker:(NSString *)tracker completion:(void (^)(SPAPIError *error, SPSession *session))completion;

// signs in a user
- (SPAPIRequest *)signInUser:(SPUser *)user completion:(void (^)(SPAPIError *error, SPSession *session))completion;

// signs out a user
- (SPAPIRequest *)signOutUser:(SPUser *)user completion:(void (^)(SPAPIError *error))completion;

// resets a user password
- (SPAPIRequest *)resetUserPassword:(SPUser *)user completion:(void (^)(SPAPIError *error))completion;

// registers a new payment card
- (SPAPIRequest *)registerPaymentCard:(SPPaymentCard *)card completion:(void (^)(SPAPIError *error, SPPaymentCard *card))completion;

// registers a new address
- (SPAPIRequest *)registerAddress:(SPAddress *)address completion:(void (^)(SPAPIError *error, SPAddress *address))completion;

// places a new order
- (SPAPIRequest *)placeOrder:(SPOrder *)order tracker:(NSString *)tracker completion:(void (^)(SPAPIError *error))completion;

- (NSString *)tracker;

@property (strong, nonatomic) NSString *APIVersion;
@property (strong, nonatomic) NSString *APIKey;
@property (strong, nonatomic) NSString *contentType;

@end
