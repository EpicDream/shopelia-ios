//
//  SPTracesAPIClient.m
//  shopelia-ios
//
//  Created by Nicolas on 19/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPTracesAPIClient.h"

@interface SPTracesAPIClient ()
@property (strong, nonatomic) NSMutableArray *pendingTraces;
@property (strong, nonatomic) NSTimer *sendTimer;
@end

@implementation SPTracesAPIClient

#pragma mark - Lazy instantiation

- (NSMutableArray *)pendingTraces
{
    if (!_pendingTraces)
    {
        _pendingTraces = [[NSMutableArray alloc] init];
    }
    return _pendingTraces;
}

#pragma mark - Traces

- (void)flushTraces
{
    NSDictionary *traces = nil;
    
    @synchronized (self)
    {
        traces = [NSDictionary dictionaryWithObject:[self.pendingTraces copy] forKey:@"traces"];
        [self.pendingTraces removeAllObjects];
    }

    SPAPIRequest *request = [self defaultRequest];
    [request setHTTPMethod:@"POST"];
    [request setURL:[self.baseURL URLByAppendingPathComponent:@"api/traces"]];
    [request setIgnoresNetworkActivityIndicator:YES];
    [request setHTTPBodyParameters:traces];
    [request startWithCompletion:nil];
}

- (void)addTrace:(NSDictionary *)trace
{
    // destroy timer
    [self.sendTimer invalidate];
    self.sendTimer = nil;
    
    // add trace
    @synchronized (self)
    {
        [self.pendingTraces addObject:trace];
    }
    
    // schedule new timer
    self.sendTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(flushTraces) userInfo:nil repeats:NO];
}

- (void)traceResourceClick:(NSString *)resource extras:(NSArray *)extras
{
    [self traceResource:resource action:@"click" extras:extras];
}

- (void)traceResourceRequest:(NSString *)resource extras:(NSArray *)extras
{
    [self traceResource:resource action:@"request" extras:extras];
}

- (void)traceResourceBottom:(NSString *)resource extras:(NSArray *)extras
{
    [self traceResource:resource action:@"bottom" extras:extras];
}

- (void)traceResourceMessage:(NSString *)resource extras:(NSArray *)extras
{
    [self traceResource:resource action:@"message" extras:extras];
}

- (void)traceResourceView:(NSString *)resource extras:(NSArray *)extras
{
    [self traceResource:resource action:@"view" extras:extras];
}

- (void)traceResourceScan:(NSString *)resource extras:(NSArray *)extras
{
    [self traceResource:resource action:@"scan" extras:extras];
}

- (void)traceResource:(NSString *)resource action:(NSString *)action extras:(NSArray *)extras
{
    if (!resource || !action)
        return ;
    
    // build trace
    NSMutableDictionary *trace = [[NSMutableDictionary alloc] init];
    [trace setObject:resource forKey:@"resource"];
    [trace setObject:action forKey:@"action"];
    for (id extra in extras)
    {
        if ([extra isKindOfClass:[NSString class]])
            [trace setObject:extra forKey:@"extra_text"];
        else if ([extra isKindOfClass:[NSNumber class]])
            [trace setObject:extra forKey:@"extra_id"];
    }
    [self addTrace:trace];
}

#pragma mark - Helpers

- (void)traceHomeView
{
    [self traceResourceView:@"Home" extras:nil];
}

- (void)traceGeorgeView
{
    [self traceResourceView:@"Georges" extras:nil];
}

- (void)traceGeorgeMessage:(NSString *)message
{
    [self traceResourceMessage:@"Georges" extras:@[message]];
}

- (void)traceCollectionView:(NSString *)UUID
{
    [self traceResourceView:@"Collection" extras:@[UUID]];
}

- (void)traceCollectionBottom:(NSString *)UUID
{
    [self traceResourceBottom:@"Collection" extras:@[UUID]];
}

- (void)traceScanView
{
    [self traceResourceView:@"Scan" extras:nil];
}

- (void)traceScanScan:(NSString *)barcode
{
    [self traceResourceScan:@"Scan" extras:@[barcode]];
}

- (void)traceProductView:(NSString *)product
{
    [self traceResourceView:@"Product" extras:@[product]];
}

- (void)traceProductClick:(NSString *)product
{
    [self traceResourceClick:@"Product" extras:@[product]];
}

- (void)traceSearchView
{
    [self traceResourceView:@"Search" extras:nil];
}

- (void)traceSearchRequest:(NSString *)request
{
    [self traceResourceRequest:@"Search" extras:@[request]];
}

@end
