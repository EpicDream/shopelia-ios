//
//  SPAPIClient+BarcodeSearch.h
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

@interface SPAPIClient (BarcodeSearch)

- (SPAPIRequest *)fetchProductWithBarcode:(NSString *)barcode fromScanner:(BOOL)fromScanner completion:(void (^)(SPAPIError *error, NSDictionary *product))completion;

@end
