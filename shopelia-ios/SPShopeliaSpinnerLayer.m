//
//  SPShopeliaSpinnerLayer.m
//  shopelia-ios
//
//  Created by Nicolas Bigot on 04/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPShopeliaSpinnerLayer.h"

@implementation SPShopeliaSpinnerLayer

@dynamic progression;

- (id)initWithLayer:(id)layer
{
    self = [super initWithLayer:layer];
    
	if (self)
    {
        SPShopeliaSpinnerLayer *other = (SPShopeliaSpinnerLayer *)layer;
        self.contentsScale = other.contentsScale;
        self.image = other.image;
        self.progression = other.progression;
        self.color = other.color;
        self.progressionColor = other.progressionColor;
	}
	return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
	if ([key isEqualToString:@"progression"])
    {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx
{
    [super drawInContext:ctx];

    CGRect drawRect = CGRectMake((self.bounds.size.width - self.image.size.width) / 2.0f,
                                 (self.bounds.size.height - self.image.size.height) / 2.0f,
                                 self.image.size.width,
                                 self.image.size.height);
    UIGraphicsPushContext(ctx);
    
    CGContextSaveGState(ctx);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -self.bounds.size.height);
    CGContextClipToMask(ctx, drawRect, self.image.CGImage);
    CGContextDrawImage(ctx, drawRect, self.image.CGImage);
    CGContextSetFillColor(ctx, CGColorGetComponents(self.color.CGColor));
    CGContextFillRect(ctx, drawRect);
    
    CGContextSetFillColor(ctx, CGColorGetComponents(self.progressionColor.CGColor));
    CGContextFillRect(ctx, CGRectMake(drawRect.origin.x,
                                      drawRect.origin.y,
                                      drawRect.size.width * self.progression,
                                      drawRect.size.height));
    
    CGContextRestoreGState(ctx);
    
    UIGraphicsPopContext();
}

@end
