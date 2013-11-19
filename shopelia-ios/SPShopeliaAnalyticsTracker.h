//
//  SPShopeliaAnalyticsTracker.h
//  shopelia-ios
//
//  Created by Nicolas on 08/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <ShopeliaSDK/ShopeliaSDK.h>

@interface SPShopeliaAnalyticsTracker : SPAnalyticsTracker

@property (strong, nonatomic) NSString *URL;

- (void)trackHome;
- (void)trackOpenSDK;
- (void)trackCollection;
- (void)trackCollectionBottomReached;
- (void)trackScan;
- (void)trackSearch;
- (void)trackDisplayProduct;
- (void)trackErrorCancel;
- (void)trackErrorNoPrice;
- (void)trackErrorNoProduct;
- (void)trackGeorgeHome;
- (void)trackGeorgeMessage:(NSString *)message;
- (void)trackPushNotificationsPermission:(BOOL)accepts;

- (void)fromCollection:(NSString *)collectionName;
- (void)fromScan:(NSString *)EAN;
- (void)fromTextualSearch:(NSString *)request;

@end
