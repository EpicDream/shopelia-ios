//
//  imageView.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/16/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "imageView.h"
#import "threadFactory.h"

@implementation imageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Asynch images

- (void)setAsynchImageWithURL:(NSString *)imageURL
{
    if (!imageURL)
        return ;
    
    dispatch_async([threadFactory backgroundImagesDispatchQueue], ^{
        NSURL *URL = [NSURL URLWithString:imageURL];
        NSData *data = [NSData dataWithContentsOfURL:URL];
        UIImage *image = [UIImage imageWithData:data];
        if (image)
        {
            dispatch_async([threadFactory mainDispatchQueue], ^{
                self.image = image;
            });
        }
    });
}


@end
