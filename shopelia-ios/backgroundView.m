//
//  backgroundView.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/16/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "backgroundView.h"
#import "UIColor+Shopelia.h"
#import "UIView+Shopelia.h"

@implementation backgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{    
    [self.layer setMasksToBounds:YES];
    self.layer.cornerRadius = 4.0;
    self.layer.borderColor = [UIColor shopeliaLightGray].CGColor;
    self.layer.borderWidth = 1.0;
}
    
    
    
    




@end
