//
//  SPImageProcessor.m
//  shopelia-ios
//
//  Created by Nicolas Bigot on 05/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPImageProcessor.h"

@implementation SPImageProcessor

+ (UIImage *)cardImage:(UIImage *)image
{
    UIImage *mask = [[UIImage imageNamed:@"card_background_mask.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -image.size.height);
    CGContextClipToMask(context, rect, mask.CGImage);
    CGContextDrawImage(context, rect, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

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
