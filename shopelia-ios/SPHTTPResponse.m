//
//  SPHTTPResponse.m
//  ShopeliaSDK
//
//  Created by Nicolas on 03/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPHTTPResponse.h"

@interface SPHTTPResponse ()

@end

@implementation SPHTTPResponse

#pragma mark - Response Properties

- (id)responseJSON
{
    return [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
}

- (NSString *)responseString
{
    return [[NSString alloc] initWithData:self.responseData encoding:self.stringEncoding];
}

- (NSStringEncoding)stringEncoding
{
    return CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding((CFStringRef)self.textEncodingName));
}

- (NSString *)textEncodingName
{
    return [self.nativeResponse textEncodingName];
}

- (NSDictionary *)allHeaderFields
{
    return [self.nativeResponse allHeaderFields];
}

- (NSString *)localizedStringForStatusCode
{
    return [NSHTTPURLResponse localizedStringForStatusCode:self.statusCode];
}

- (NSInteger)statusCode
{
    return [self.nativeResponse statusCode];
}

#pragma mark - Lifecycle

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ <%p>\nSTATUS CODE: %d\nURL: %@\nHEADERS: %@\nDATA: %@", [self class], self, self.statusCode, self.URL, self.allHeaderFields, self.responseData];
}

@end
