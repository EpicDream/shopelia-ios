//
//  SPProductOptionValue.h
//  ShopeliaSDK
//
//  Created by Nicolas on 04/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPModelObject.h"

@interface SPProductOptionValue : SPModelObject

// returns the option's most representative value
- (NSString *)representativeValue;

// returns wether the receiver has to be treated as an image
- (BOOL)isImage;

// returns the image url of the receiver (if it's an image)
- (NSURL *)imageURL;

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *source;

@end
