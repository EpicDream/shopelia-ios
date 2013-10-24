//
//  SPHTTPClient.h
//  ShopeliaSDK
//
//  Created by Nicolas on 03/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPSingletonObject.h"
#import "SPHTTPRequest.h"

@interface SPHTTPClient : SPSingletonObject

// returns a default request
- (id)defaultRequest;

@property (strong, nonatomic) NSURL *baseURL;

@end
