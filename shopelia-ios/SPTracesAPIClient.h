//
//  SPTracesAPIClient.h
//  shopelia-ios
//
//  Created by Nicolas on 19/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <ShopeliaSDK/ShopeliaSDK.h>

@interface SPTracesAPIClient : SPAPIV1Client

- (void)traceHomeView;
- (void)traceGeorgeView;
- (void)traceGeorgeMessage:(NSString *)message;
- (void)traceCollectionView:(NSString *)UUID;
- (void)traceCollectionBottom:(NSString *)UUID;
- (void)traceScanView;
- (void)traceScanScan:(NSString *)barcode;
- (void)traceProductView:(NSString *)product;
- (void)traceProductClick:(NSString *)product;
- (void)traceSearchView;
- (void)traceSearchRequest:(NSString *)request;

@end
