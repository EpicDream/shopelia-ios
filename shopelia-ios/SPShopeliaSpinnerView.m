//
//  SPShopeliaSpinnerView.m
//  shopelia-ios
//
//  Created by Nicolas Bigot on 04/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPShopeliaSpinnerView.h"
#import "SPShopeliaSpinnerLayer.h"
#import "UIColor+Shopelia.h"

@interface SPShopeliaSpinnerView ()
@property (strong, nonatomic) NSArray *colors;
@property (assign, nonatomic) BOOL backward;
@property (assign, nonatomic) NSUInteger currentColorIndex;
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
    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:from];
    animation.toValue = [NSNumber numberWithFloat:to];
    animation.delegate = self;
    [self.shopeliaLayer addAnimation:animation forKey:nil];
    self.shopeliaLayer.progression = to;
}

- (void)fetchNextColors
{
    if (self.shopeliaLayer.color == nil)
    {
        [self.shopeliaLayer setColor:self.colors[0]];
        [self.shopeliaLayer setProgressionColor:self.colors[1]];
        self.currentColorIndex = 1;
        return ;
    }
    
    self.currentColorIndex++;
    if (self.currentColorIndex >= self.colors.count)
        self.currentColorIndex = 0;
        
    if (self.backward)
    {
        self.shopeliaLayer.color = [self.colors objectAtIndex:self.currentColorIndex];
    }
    else
    {
        self.shopeliaLayer.progressionColor = [self.colors objectAtIndex:self.currentColorIndex];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        self.backward = !self.backward;
        [self fetchNextColors];
        [self launchAnimationFrom:self.backward ? 1.0f : 0.0f to:self.backward ? 0.0f : 1.0f];
    }
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
    self.layer.delegate = self;
    self.image = [UIImage imageNamed:@"loader_icon.png"];
    [self.layer setNeedsDisplay];
    
    self.colors = @[
                    [UIColor shopeliaGreen],
                    [UIColor shopeliaBlue],
                    [UIColor shopeliaRed],
                    [UIColor shopeliaYellow],
                    [UIColor shopeliaDarkBlue]
                    ];
    [self fetchNextColors];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    
    [self stopAnimating];
}

- (void)dealloc
{
    
}

@end
