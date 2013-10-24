//
//  SPAddPaymentCardViewController.h
//  ShopeliaSDK
//
//  Created by Nicolas on 19/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPFormViewController.h"

@class SPAddPaymentCardViewController;

@protocol SPAddPaymentCardViewControllerDelegate <NSObject>

// notify the delegate that a new address as been entered
- (void)addPaymentCardViewController:(SPAddPaymentCardViewController *)viewController didEnterPaymentCard:(SPPaymentCard *)card;

@end

@interface SPAddPaymentCardViewController : SPFormViewController

@property (weak, nonatomic) id <SPAddPaymentCardViewControllerDelegate> delegate;

@end
