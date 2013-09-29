//
//  SPHTTPResponse.h
//  ShopeliaSDK
//
//  Created by Nicolas on 03/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPResponse : NSObject

// returns all the HTTP header fields
- (NSDictionary *)allHeaderFields;

// returns a localized string for the response's status code
- (NSString *)localizedStringForStatusCode;

// returns the status code
- (NSInteger)statusCode;

// returns the response data as a string
- (NSString *)responseString;

// returns the response data as a JSON object
- (id)responseJSON;

// returns the text enciding name string
- (NSString *)textEncodingName;

// returns the text encoding
- (NSStringEncoding)stringEncoding;

@property (strong, nonatomic) NSHTTPURLResponse *nativeResponse;
@property (strong, nonatomic) NSData *responseData;
@property (strong, nonatomic) NSURL *URL;

@end
