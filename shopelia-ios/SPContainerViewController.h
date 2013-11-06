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

@interface SPContainerViewController : SPViewController

@property (strong, nonatomic) SPWaitingMessageView *waitingMessageView;
@property (strong, nonatomic) SPErrorMessageView *errorMessageView;

@property (assign, nonatomic) BOOL showsAlgoliaSearch;
@property (assign, nonatomic) BOOL showsGeorge;

@end
