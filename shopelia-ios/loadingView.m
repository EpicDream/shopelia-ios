//
//  loadingView.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/26/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "loadingView.h"
#import "SpinnerView.h"


@implementation loadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
         [SpinnerView loadIntoView: self];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}


@end
