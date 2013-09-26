//
//  SpinnerView.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/24/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpinnerView : UIView


@property (strong, nonatomic) NSMutableArray *colors;
@property (assign, nonatomic) int iteration;


+ (SpinnerView *) loadIntoView: (UIView *) view; 

@end
