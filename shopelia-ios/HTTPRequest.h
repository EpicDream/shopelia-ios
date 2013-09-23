//
//  HTTPRequest.h
//  ShopeliaSDK
//
//  Created by Nicolas on 03/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPResponse.h"

@interface HTTPRequest : NSObject

// async starts the request
- (void)start;

// async starts the request given a specific completion block
- (void)startWithCompletion:(void (^)(NSError *error, id response))block;

// cancels the request
- (void)cancel;

// returns all the HTTP header fields
- (NSDictionary *)allHTTPHeaderFields;

// sets all the HTTP header fields
- (void)setAllHTTPHeaderFields:(NSDictionary *)fields;

// returns the value for a given HTTP header field
- (NSString *)valueForHTTPHeaderField:(NSString *)field;

// add a value to the given HTTP header field (comma separated if any existing)
- (void)addValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

// set a value to the given HTTP header field (replaces all existing value)
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

@property (strong, nonatomic) NSURL *URL;
@property (strong, nonatomic) NSNumber *timeoutInterval;
@property (strong, nonatomic) NSString *HTTPMethod;
@property (strong, nonatomic) NSData *HTTPBody;
@property (strong, nonatomic) NSDictionary *URLParameters;
@property (strong, nonatomic) void (^completionBlock)(NSError *error, id response);

@end
