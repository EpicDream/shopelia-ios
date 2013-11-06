//
//  SPImageProcessor.m
//  shopelia-ios
//
//  Created by Nicolas Bigot on 05/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPImageProcessor.h"

@implementation SPImageProcessor

+ (UIImage *)resizedImage:(UIImage *)image toSize:(CGSize)size
{
    if (CGSizeEqualToSize(size, image.size))
        return image;
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
