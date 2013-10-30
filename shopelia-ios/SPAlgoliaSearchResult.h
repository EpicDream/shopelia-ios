//
//  SPAlgoliaSearchResult.h
//  shopelia-ios
//
//  Created by Nicolas on 30/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPAlgoliaSearchResult : SPModelObject

@property (strong, nonatomic) SPProduct *product;
@property (strong, nonatomic) NSString *barcode;

@end
