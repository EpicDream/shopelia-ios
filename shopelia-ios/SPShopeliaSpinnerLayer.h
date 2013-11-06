//
//  SPShopeliaSpinnerLayer.h
//  shopelia-ios
//
//  Created by Nicolas Bigot on 04/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface SPShopeliaSpinnerLayer : CALayer

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGFloat progression;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIColor *progressionColor;

@end
