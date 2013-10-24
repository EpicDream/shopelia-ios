//
//  SPHTTPRequest.h
//  ShopeliaSDK
//
//  Created by Nicolas on 03/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPHTTPResponse.h"

@interface SPHTTPRequest : NSObject

// returns wether the request is running
- (BOOL)isRunning;

// async starts the request
- (void)start;

// async starts the request given a specific completion block
- (void)startWithCompletion:(void (^)(NSError *error, id response))block;

// cancels the request
- (void)cancel;

// cancels the request and clears the completion block
- (void)cancelAndClearCompletionBlock;

// returns all the HTTP header fields
- (NSDictionary *)allHTTPHeaderFields;

// sets all the HTTP header fields
- (void)setAllHTTPHeaderFields:(NSDictionary *)fields;

// returns the value for a given HTTP header field
- (NSString *)valueForHTTPHeaderField:(NSString *)field;

// adds a value to the given HTTP header field (comma separated if any existing)
- (void)addValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

// sets a value to the given HTTP header field (replaces all existing value)
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

// set HTTP body to be a JSON representation of the given dictionary
- (void)setHTTPBodyParameters:(NSDictionary *)bodyParameters;

@property (strong, nonatomic) NSURL *URL;
@property (strong, nonatomic) NSNumber *timeoutInterval;
@property (strong, nonatomic) NSString *HTTPMethod;
@property (strong, nonatomic) NSData *HTTPBody;
@property (strong, nonatomic) NSDictionary *URLParameters;
@property (strong, nonatomic) void (^completionBlock)(NSError *error, id response);
@property (assign, nonatomic) BOOL ignoresNetworkActivityIndicator;

@end