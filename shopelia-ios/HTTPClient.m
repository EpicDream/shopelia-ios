//
//  HTTPClient.m
//  ShopeliaSDK
//
//  Created by Nicolas on 03/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient

#pragma mark - Request Factory

- (id)defaultRequest
{
    HTTPRequest *request = [[HTTPRequest alloc] init];
   
    return request;
}

- (id)getRequest
{
    HTTPRequest *request = [self defaultRequest];
    
    [request setHTTPMethod:@"GET"];
    return request;
}

- (id)postRequest
{
    HTTPRequest *request = [self defaultRequest];
    
    [request setHTTPMethod:@"POST"];
    return request;
}

@end
