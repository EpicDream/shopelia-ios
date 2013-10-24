//
//  SPConditionWebNavigatorViewController.h
//  ShopeliaSDK
//
//  Created by Nicolas on 21/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPWebNavigatorViewController.h"

@class SPConditionWebNavigatorViewController;

@protocol SPConditionWebNavigatorViewControllerDelegate <NSObject>

- (void)conditionWebNavigatorViewControllerDidAccept:(SPConditionWebNavigatorViewController *)viewController;
- (void)conditionWebNavigatorViewControllerDidRefuse:(SPConditionWebNavigatorViewController *)viewController;

@end

@interface SPConditionWebNavigatorViewController : SPWebNavigatorViewController

@property (weak, nonatomic) id <SPConditionWebNavigatorViewControllerDelegate> delegate;

@end
