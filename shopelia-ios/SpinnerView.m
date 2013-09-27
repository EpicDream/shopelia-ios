 //
//  SpinnerView.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/24/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "SpinnerView.h"
#import "UIImage+Shopelia.h"
#import "UIColor+Shopelia.h"
#import <QuartzCore/QuartzCore.h>
#import "SpinnerLayer.h"

@implementation SpinnerView

@synthesize colors;
@synthesize iteration;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        self.colors = [NSMutableArray arrayWithObjects:[UIColor shopeliaGreen],[UIColor shopeliaBlue],[UIColor shopeliaRed],[UIColor shopeliaYellow],[UIColor shopeliaDarkBlue],nil];
        self.opaque = NO;
        //self.spinnerPosition = 0;
    }
    return self;
}


+ (Class) layerClass {
    return [SpinnerLayer class];
}


+ (SpinnerView *) loadIntoView:(UIView *)view withSize:(NSString *) size{
    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loader-icon.png"]];

    if ([size isEqualToString: @"small"]) {
        image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loader-icon-small.png"]];
    }
    
    SpinnerView* spinner = [[SpinnerView alloc] initWithFrame: CGRectMake((view.frame.size.width - image.frame.size.width)/2,(view.frame.size.height -image.frame.size.height)/2,image.frame.size.width,image.frame.size.height)];
    ((SpinnerLayer *) spinner.layer).currentColor = [spinner.colors objectAtIndex: 0];
    ((SpinnerLayer *) spinner.layer).nextColor = [spinner.colors objectAtIndex: 1];
        
    ((SpinnerLayer *) spinner.layer).ellipseFrame = CGRectMake(image.frame.origin.x,image.frame.origin.y,image.frame.size.width,image.frame.size.height);
    ((SpinnerLayer *) spinner.layer).mask = image.layer;

    spinner.iteration = 0;
    [spinner animatePositionOnLayer: ((SpinnerLayer *) spinner.layer) from:0 to:1];
    [view addSubview:spinner];
 
    return spinner;
}



- (void) removeSpinner {
    [((SpinnerLayer *) self.layer) removeAllAnimations];
    [super removeFromSuperview];

}

- (void) animatePositionOnLayer: (SpinnerLayer *) layer from: (double) start to: (double) end {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"spinnerPosition"];
    anim.duration = 1.0;
    anim.delegate = self;
    anim.fromValue = [NSNumber numberWithDouble:start];
    anim.toValue = [NSNumber numberWithDouble:end];
    [layer addAnimation:anim forKey:@"animatePosition"];
    layer.spinnerPosition = end;
}



- (UIColor *) getCurrentColor: (UIColor *) color {
    int index = [colors indexOfObject:color];
    return [colors objectAtIndex:index];
}


- (UIColor *) getNextColor: (UIColor *) color {
    int index = [colors indexOfObject:color];
    if ( (index + 1) < colors.count ) {
        return [colors objectAtIndex:(index + 1)];
    } else {
        return [colors objectAtIndex:0];
    }
    
}

- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        self.iteration += 1;
        if (self.iteration % 2 == 0) {
            ((SpinnerLayer *) self.layer).nextColor =  [self getNextColor:((SpinnerLayer *) self.layer).currentColor];
            [self animatePositionOnLayer: ((SpinnerLayer *) self.layer) from:0 to:1];
        } else {
            ((SpinnerLayer *) self.layer).currentColor =  [self getNextColor:((SpinnerLayer *) self.layer).nextColor] ;
            [self animatePositionOnLayer: ((SpinnerLayer *) self.layer) from:1 to:0];
        }
        
    }
   
}



@end
