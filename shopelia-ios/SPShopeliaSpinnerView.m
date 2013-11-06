//
//  SPShopeliaSpinnerView.m
//  shopelia-ios
//
//  Created by Nicolas Bigot on 04/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPShopeliaSpinnerView.h"
#import "SPShopeliaSpinnerLayer.h"

@interface SPShopeliaSpinnerView ()

@end

@implementation SPShopeliaSpinnerView

#pragma mark - Animations

- (void)startAnimating
{
    [self launchAnimationFrom:0.0f to:1.0f];
}

- (void)stopAnimating
{
    [self.layer removeAllAnimations];
}

- (void)launchAnimationFrom:(CGFloat)from to:(CGFloat)to
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progression"];
    
    animation.duration = 1.0;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:from];
    animation.toValue = [NSNumber numberWithFloat:to];
    [self.shopeliaLayer addAnimation:animation forKey:nil];
}

#pragma mark - View

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    [(SPShopeliaSpinnerLayer *)(self.layer) setImage:image];
}

#pragma mark - Layer

- (SPShopeliaSpinnerLayer *)shopeliaLayer
{
    return (SPShopeliaSpinnerLayer *)(self.layer);
}

+ (Class)layerClass
{
    return [SPShopeliaSpinnerLayer class];
}

#pragma mark - Lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.image = [UIImage imageNamed:@"loader_icon.png"];
    [self.layer setNeedsDisplay];
    
    [self.shopeliaLayer setColor:[UIColor redColor]];
    [self.shopeliaLayer setProgressionColor:[UIColor blueColor]];
    
    [self performSelector:@selector(startAnimating) withObject:nil afterDelay:1.0f];
}

@end
