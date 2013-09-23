//
//  HTTPRequest.m
//  ShopeliaSDK
//
//  Created by Nicolas on 03/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "HTTPRequest.h"

@interface HTTPRequest () <NSURLConnectionDataDelegate>
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSHTTPURLResponse *response;
@property (strong, nonatomic) NSMutableDictionary *HTTPHeaders;
@end

@implementation HTTPRequest

#pragma mark - Lazy Instantiation

- (NSMutableData *)data
{
    if (!_data)
    {
        _data = [[NSMutableData alloc] init];
    }
    return _data;
}

#pragma mark - URL Parameters

- (NSString *)encodedDictionary:(NSDictionary*)dictionary
{
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    
    for (NSString *key in dictionary)
    {
        NSString *encodedValue = [self SPPercentEncodedString:[dictionary objectForKey:key]];
        NSString *encodedKey = [self SPPercentEncodedString:key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedString = [parts componentsJoinedByString:@"&"];
    return [@"?" stringByAppendingString:encodedString];
}

#pragma mark - Request Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.response = (NSHTTPURLResponse *)response;
    [self.data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.completionBlock)
    {
        id response = [[[self responseClass] alloc] init];
        [response setResponseData:self.data];
        [response setNativeResponse:self.response];
        [response setURL:self.URL];
        
        self.completionBlock(nil, response);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.completionBlock)
    {
        self.completionBlock(error, nil);
    }
}

#pragma mark - Request Execution

- (void)start
{
    [self cancel];
    
    // build request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:self.HTTPMethod];
    [request setTimeoutInterval:[self.timeoutInterval doubleValue]];
    if (self.URLParameters.count)
        [request setURL:[NSURL URLWithString:[[self.URL absoluteString] stringByAppendingString:[self encodedDictionary:self.URLParameters]]]];
    else
        [request setURL:self.URL];
    [request setAllHTTPHeaderFields:self.allHTTPHeaderFields];
    [request setHTTPBody:self.HTTPBody];

    // build connection
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [self.connection start];
}

- (void)startWithCompletion:(void (^)(NSError *error, id response))block
{
    self.completionBlock = block;
    [self start];
}

- (void)cancel
{
    [self.connection cancel];
    self.connection = nil;
    self.response = nil;
    self.data = nil;
}

#pragma mark - Request Headers

- (NSDictionary *)allHTTPHeaderFields
{
    return self.HTTPHeaders;
}

- (NSString *)valueForHTTPHeaderField:(NSString *)field
{
    return [self.HTTPHeaders objectForKey:field];
}

- (void)setAllHTTPHeaderFields:(NSDictionary *)fields
{
    self.HTTPHeaders = [NSMutableDictionary dictionaryWithDictionary:fields];
}

- (void)addValue:(NSString *)value forHTTPHeaderField:(NSString *)field
{
    NSString *currentValue = [self valueForHTTPHeaderField:field];
    
    if (!currentValue)
    {
        [self setValue:value forHTTPHeaderField:field];
    }
    else
    {
        [self setValue:[currentValue stringByAppendingFormat:@",%@", value] forHTTPHeaderField:field];
    }
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field
{
    if (!self.HTTPHeaders)
        self.HTTPHeaders = [NSMutableDictionary dictionary];
    [self.HTTPHeaders setObject:value forKey:field];
}

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self setHTTPMethod:@"GET"];
        [self setTimeoutInterval:@10.0f];
    }
    return self;
}

- (Class)responseClass
{
    return [HTTPResponse class];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ <%p>\nMETHOD: %@\nURL: %@\nURL PARAMETERS: %@\nHEADERS: %@\nBODY: %@", [self class], self, self.HTTPMethod, self.URL, self.URLParameters, self.HTTPHeaders, self.HTTPBody];
}

- (NSString *) SPPercentEncodedString: (NSString *) string
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
}

@end
