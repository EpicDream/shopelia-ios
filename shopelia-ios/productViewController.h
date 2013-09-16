//
//  productViewController.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/11/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface productViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *shippingPrice;
@property (strong, nonatomic) NSArray* products;
@property (strong, nonatomic) NSDictionary* cheaperProduct;



@end
