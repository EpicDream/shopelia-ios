//
//  SPHTTPClient.m
//  ShopeliaSDK
//
//  Created by Nicolas on 03/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPHTTPClient.h"

@implementation SPHTTPClient

#pragma mark - Request Factory

- (id)defaultRequest
{
    SPHTTPRequest *request = [[SPHTTPRequest alloc] init];
   
    return request;
}

- (id)getRequest
{
    SPHTTPRequest *request = [self defaultRequest];
    
    [request setHTTPMethod:@"GET"];
    return request;
}

- (id)postRequest
{
    SPHTTPRequest *request = [self defaultRequest];
    
    [request setHTTPMethod:@"POST"];
    return request;
}

@end
