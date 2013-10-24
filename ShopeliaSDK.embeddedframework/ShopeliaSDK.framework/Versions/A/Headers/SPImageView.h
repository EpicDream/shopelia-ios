//
//  SPImageView.h
//  ShopeliaSDK
//
//  Created by Nicolas on 11/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPViewCustomization.h"
#import "SPVisualFactory.h"

@interface SPImageView : UIImageView <SPViewCustomization>

- (void)setAsynchImageWithURL:(NSURL *)imageURL;

@end
