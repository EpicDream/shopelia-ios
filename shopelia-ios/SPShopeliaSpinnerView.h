//
//  SPShopeliaSpinnerView.h
//  shopelia-ios
//
//  Created by Nicolas Bigot on 04/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPShopeliaSpinnerView : UIView

- (void)startAnimating;
- (void)stopAnimating;

@property (strong, nonatomic) UIImage *image;

@end
