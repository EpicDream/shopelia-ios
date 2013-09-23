//
//  HTTPClient.h
//  ShopeliaSDK
//
//  Created by Nicolas on 03/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPRequest.h"

@interface HTTPClient : NSObject

// returns a default request
- (id)defaultRequest;

// returns a GET request
- (id)getRequest;

// returns a POST request
- (id)postRequest;

@property (strong, nonatomic) NSURL *baseURL;

@end
