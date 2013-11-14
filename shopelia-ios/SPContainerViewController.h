//
//  SPContainerViewController.h
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPWaitingMessageView.h"
#import "SPErrorMessageView.h"
#import "SPViewController+Utilities.h"

@interface SPContainerViewController : SPViewController <UIScrollViewDelegate>

- (void)setupUIForWaitingMessageView;
- (void)setupUIForErrorMessageView;
- (void)setupUIForContentView;
- (CGFloat)chatButtonOverHeight;

@property (strong, nonatomic) SPWaitingMessageView *waitingMessageView;
@property (strong, nonatomic) SPErrorMessageView *errorMessageView;

@property (assign, nonatomic) BOOL showsAlgoliaSearch;
@property (assign, nonatomic) BOOL showsChat;

@end
