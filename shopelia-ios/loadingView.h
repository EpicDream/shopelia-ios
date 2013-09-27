//
//  loadingView.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/26/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "backgroundView.h"
#import "SpinnerView.h"


@interface loadingView : backgroundView

@property (strong,nonatomic) SpinnerView* spinner;

@end
