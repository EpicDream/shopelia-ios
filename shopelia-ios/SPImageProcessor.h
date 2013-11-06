//
//  SPImageProcessor.h
//  shopelia-ios
//
//  Created by Nicolas Bigot on 05/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPImageProcessor : NSObject

+ (UIImage *)resizedImage:(UIImage *)image toSize:(CGSize)size;

@end
