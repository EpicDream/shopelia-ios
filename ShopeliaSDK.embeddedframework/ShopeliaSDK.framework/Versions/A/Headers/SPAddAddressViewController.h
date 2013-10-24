//
//  SPAddAddressViewController.h
//  ShopeliaSDK
//
//  Created by Nicolas on 16/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPFormViewController.h"
#import "SPAddress.h"

@class SPAddAddressViewController;

@protocol SPAddAddressViewControllerDelegate <NSObject>

// notify the delegate that a new address as been entered
- (void)addAddressViewController:(SPAddAddressViewController *)viewController didEnterAddress:(SPAddress *)address;

@end

@interface SPAddAddressViewController : SPFormViewController

@property (weak, nonatomic) id <SPAddAddressViewControllerDelegate> delegate;
@property (assign, nonatomic, getter = willRegisterAddress) BOOL registersAddress;

@end
