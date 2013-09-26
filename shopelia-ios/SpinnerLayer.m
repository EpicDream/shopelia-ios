//
//  SpinnerLayer.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/25/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "SpinnerLayer.h"
#import "UIView+Shopelia.m"
#import "UIColor+Shopelia.h"


@implementation SpinnerLayer

@synthesize spinnerPosition;
@synthesize currentColor;
@synthesize nextColor;



- (id) initWithLayer:(id)layer {
	if(self = [super initWithLayer:layer]) {
		if([layer isKindOfClass:[SpinnerLayer class]]) {
            self.contentsScale = [UIScreen mainScreen].scale;
			SpinnerLayer *other = (SpinnerLayer*)layer;
            self.spinnerPosition = other.spinnerPosition;
            self.currentColor = other.currentColor;
            self.nextColor = other.nextColor;
            self.ellipseFrame = other.ellipseFrame;
		}
	}
	return self;
}


+ (BOOL)needsDisplayForKey:(NSString *)key {
	if ([key isEqualToString:@"spinnerPosition"]){
        return YES;
    }
	else {
        return [super needsDisplayForKey:key];
    }
}


- (void) drawInContext:(CGContextRef)ctx {
    UIGraphicsPushContext(ctx);
    //call function to draw Ellipse
    [self drawEllipse:ctx];
        
    //call function to draw gradient
    [self drawEllipseWithRectangles:ctx];
    
}

-(void)drawEllipse:(CGContextRef)context{
    CGContextSaveGState(context);
    
    //Set color of current context
    [[UIColor clearColor] set];
    
    //Draw ellipse <- I know we’re drawing a circle, but a circle is just a special ellipse.
    CGRect ellipseRect = self.ellipseFrame;
    CGContextFillEllipseInRect(context, ellipseRect);
    CGContextRestoreGState(context);
    
}




-(void)drawEllipseWithRectangles:(CGContextRef)context{
    
    CGContextSaveGState(context);
    
    //UIGraphicsBeginImageContextWith(self.frame.size);
    UIGraphicsBeginImageContextWithOptions((self.frame.size), NO, 0.0);
    
    CGContextRef newContext = UIGraphicsGetCurrentContext();
    
    // Translate and scale image to compnesate for Quartz's inverted coordinate system
    CGContextTranslateCTM(newContext,0.0,self.frame.size.height);
    CGContextScaleCTM(newContext, 1.0, -1.0);
    
    
    
    //Set color of current context
    [[UIColor redColor] set];
    
    //Draw ellipse <- I know we’re drawing a circle, but a circle is just a special ellipse.
    CGRect ellipseRect = self.ellipseFrame;
    CGContextFillEllipseInRect(newContext, ellipseRect);
    
    CGImageRef mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    
    
    CGContextClipToMask(context, self.bounds, mask);
    
    [self drawRectangles:context];
    
    
    CGImageRelease(mask);
    CGContextRestoreGState(context);
    
    
}



- (void) drawRectangles: (CGContextRef) context {
    
    CGRect originalRectangle = CGRectMake(self.ellipseFrame.origin.x + self.spinnerPosition * self.ellipseFrame.size.width, self.ellipseFrame.origin.y, self.ellipseFrame.size.width * (1-self.spinnerPosition), self.ellipseFrame.size.height);
    const CGFloat* startComponents = CGColorGetComponents(currentColor.CGColor);
    
    CGContextSetRGBFillColor(context, startComponents[0] , startComponents[1],startComponents[2] ,CGColorGetAlpha(currentColor.CGColor));
    CGContextSetRGBStrokeColor(context, startComponents[0] , startComponents[1],startComponents[2] ,CGColorGetAlpha(currentColor.CGColor));
    CGContextFillRect(context, originalRectangle);
    
    
    CGRect newRectangle = CGRectMake(self.ellipseFrame.origin.x, self.ellipseFrame.origin.y, self.ellipseFrame.size.width * self.spinnerPosition,  self.ellipseFrame.size.height);
    const CGFloat* endComponents = CGColorGetComponents(nextColor.CGColor);
    
    CGContextSetRGBFillColor(context, endComponents[0] , endComponents[1],endComponents[2] ,CGColorGetAlpha(nextColor.CGColor));
    CGContextSetRGBStrokeColor(context, endComponents[0] , endComponents[1],endComponents[2] ,CGColorGetAlpha(nextColor.CGColor));
    CGContextFillRect(context, newRectangle);
 
}




@end
