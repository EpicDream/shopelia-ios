//
//  SPDevicesAPIClient.h
//  shopelia-ios
//
//  Created by Nicolas on 13/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <ShopeliaSDK/ShopeliaSDK.h>

@interface SPDevicesAPIClient : SPAPIV1Client

- (void)handleNewDeviceToken:(NSData *)token;

@end
