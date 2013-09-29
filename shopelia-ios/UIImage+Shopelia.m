//
//  UIImage+Shopelia.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/24/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "UIImage+Shopelia.h"

@implementation UIImage (Shopelia)


+ (UIImage *) changeColor: (UIImage *)image withColor: (UIColor *) color{
        UIGraphicsBeginImageContext(image.size);
        
        CGRect contextRect;
        contextRect.origin.x = 0.0f;
        contextRect.origin.y = 0.0f;
        contextRect.size = [image size];
        CGFloat scale = [[UIScreen mainScreen] scale];
        // Retrieve source image and begin image context
        CGSize itemImageSize = [image size];
        CGPoint itemImagePosition;
        itemImagePosition.x = ceilf((contextRect.size.width - itemImageSize.width) / 2);
        itemImagePosition.y = ceilf((contextRect.size.height - itemImageSize.height) );
        
        UIGraphicsBeginImageContextWithOptions(contextRect.size, NO, scale);
        
        CGContextRef c = UIGraphicsGetCurrentContext();
        // Setup shadow
        // Setup transparency layer and clip to mask
        CGContextBeginTransparencyLayer(c, NULL);
        CGContextScaleCTM(c, 1.0, -1.0);
        CGContextClipToMask(c, CGRectMake(itemImagePosition.x, -itemImagePosition.y, itemImageSize.width,  -itemImageSize.height), [image CGImage]);
        
        
        CGContextSetFillColorWithColor(c, color.CGColor);
        //CGContextSetRGBFillColor(c, 1, 0, 0., 1);
        contextRect.size.height = -contextRect.size.height;
        contextRect.size.height -= 15;
        // Fill and end the transparency layer
        CGContextFillRect(c, contextRect);
        CGContextEndTransparencyLayer(c);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }

@end
