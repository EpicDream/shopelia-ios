//
//  SpinnerLayer.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/25/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface SpinnerLayer : CALayer 

@property (assign,nonatomic) float spinnerPosition;
@property (strong, nonatomic) UIColor *currentColor;
@property (strong, nonatomic) UIColor *nextColor;
@property (assign, nonatomic) CGRect ellipseFrame;


- (void) animatePositionWithIndexColor: (int) i;
- (id) initWithLayer:(id)layer ;

@end
