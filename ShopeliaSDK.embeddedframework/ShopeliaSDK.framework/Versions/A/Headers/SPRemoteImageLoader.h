//
//  SPRemoteImageLoader.h
//  ShopeliaSDK
//
//  Created by Nicolas on 05/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPRemoteImageLoader : NSObject

+ (id)sharedInstance;
- (void)fetchImageForURL:(NSURL *)imageURL completion:(void (^)(NSURL *imageURL, UIImage *image))completion;

@end
