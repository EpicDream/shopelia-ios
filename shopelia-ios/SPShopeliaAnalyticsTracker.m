//
//  SPShopeliaAnalyticsTracker.m
//  shopelia-ios
//
//  Created by Nicolas on 08/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPShopeliaAnalyticsTracker.h"

#define COLLECTION_NAME_KEY @"collectionName"
#define FROM_KEY @"from"
#define BARCODE_KEY @"barcode"
#define REQUEST_KEY @"request"
#define URL_KEY @"URL"
#define ERROR_KEY @"error"

@interface SPShopeliaAnalyticsTracker ()
@property (strong, nonatomic) Mixpanel *mixpanel;
@property (strong, nonatomic) NSString *from;
@property (strong, nonatomic) NSString *collectionName;
@property (strong, nonatomic) NSString *barcode;
@property (strong, nonatomic) NSString *request;
@property (strong, nonatomic) NSString *error;
@end

@implementation SPShopeliaAnalyticsTracker

#pragma mark - Lazy instanciation

- (Mixpanel *)mixpanel
{
    if (!_mixpanel)
    {
        _mixpanel = [[Mixpanel alloc] initWithToken:@"09c27c4e64581418e9eb3ce47cbc36e3" andFlushInterval:60.0f];
        [_mixpanel setShowNetworkActivityIndicator:NO];
        [_mixpanel setFlushOnBackground:YES];
    }
    return _mixpanel;
}

#pragma mark - Tracker

- (void)fromCollection:(NSString *)collectionName
{
    self.from = @"Collection";
    self.barcode = nil;
    self.collectionName = collectionName;
    self.request = nil;
}

- (void)fromScan:(NSString *)EAN
{
    self.from = @"Scan";
    self.barcode = EAN;
    self.collectionName = nil;
    self.request = nil;
}

- (void)fromTextualSearch:(NSString *)request
{
    self.from = @"Textual Search";
    self.barcode = nil;
    self.collectionName = nil;
    self.request = request;
}

- (void)trackEvent:(NSString *)name properties:(NSDictionary *)properties
{
    [self.mixpanel track:name properties:properties];
}

- (void)trackErrorCancel
{
    self.error = @"Cancel";
    [self trackError];
}

- (void)trackErrorNoPrice
{
    self.error = @"No Price";
    [self trackError];
}

- (void)trackErrorNoProduct
{
    self.error = @"No Product";
    [self trackError];
}

- (void)trackError
{
    NSDictionary *properties = [self propertiesWithKeys:@[ERROR_KEY, BARCODE_KEY, FROM_KEY, REQUEST_KEY]];
    [self trackEvent:@"Error" properties:properties];
}

- (void)trackSearch
{
    NSDictionary *properties = [self propertiesWithKeys:@[URL_KEY, BARCODE_KEY, FROM_KEY, REQUEST_KEY]];
    [self trackEvent:@"Search" properties:properties];
}

- (void)trackDisplayProduct
{
    NSDictionary *properties = [self propertiesWithKeys:@[URL_KEY, BARCODE_KEY, FROM_KEY, REQUEST_KEY]];
    [self trackEvent:@"Display Product" properties:properties];
}

- (void)trackOpenSDK
{
    NSDictionary *properties = [self propertiesWithKeys:@[URL_KEY, COLLECTION_NAME_KEY, BARCODE_KEY, FROM_KEY, REQUEST_KEY]];
    [self trackEvent:@"Open SDK" properties:properties];
}

- (void)trackCollection
{
    NSDictionary *properties = [self propertiesWithKeys:@[COLLECTION_NAME_KEY]];
    [self trackEvent:@"Collection" properties:properties];
}

- (void)trackCollectionBottomReached
{
    NSDictionary *properties = [self propertiesWithKeys:@[COLLECTION_NAME_KEY]];
    [self trackEvent:@"Collection Bottom Reached" properties:properties];
}

- (void)trackHome
{
    [self trackEvent:@"Home" properties:nil];
}

- (void)trackScan
{
    [self trackEvent:@"Scan" properties:nil];
}

- (void)trackGeorgeHome
{
    [self trackEvent:@"Georges Home" properties:nil];
}

- (void)trackGeorgeMessage:(NSString *)message
{
    [self trackEvent:@"Georges Message" properties:@{@"Message" : message}];
}

- (void)trackPushNotificationsPermission:(BOOL)accepts
{
    [self trackEvent:@"Push Notifications Permission" properties:@{@"Value" : accepts ? @"YES" : @"NO"}];
}

- (NSDictionary *)propertiesWithKeys:(NSArray *)keys
{
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    
    for (NSString *key in keys)
    {
        id value = [self valueForKey:key];
        
        if (value)
        {
            if ([key isEqualToString:URL_KEY])
                [properties setObject:value forKey:@"URL"];
            else if ([key isEqualToString:COLLECTION_NAME_KEY])
                [properties setObject:value forKey:@"Collection Name"];
            else if ([key isEqualToString:FROM_KEY])
                [properties setObject:value forKey:@"From"];
            else if ([key isEqualToString:BARCODE_KEY])
                [properties setObject:value forKey:@"EAN"];
            else if ([key isEqualToString:REQUEST_KEY])
                [properties setObject:value forKey:@"Request"];
            else if ([key isEqualToString:ERROR_KEY])
                [properties setObject:@"true" forKey:self.error];
        }
    }
    return properties;
}

- (void)flush
{
    [super flush];
    
    [self.mixpanel flush];
}

- (void)reset
{
    [super reset];
    
    [self.mixpanel reset];
}

- (void)dealloc
{
    
}

@end
