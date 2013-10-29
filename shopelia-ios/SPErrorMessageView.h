//
//  SPErrorMessageView.h
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPErrorMessageView : SPView

@property (weak, nonatomic) IBOutlet SPLabel *messageLabel;
@property (weak, nonatomic) IBOutlet SPButton *actionButton;

@end
