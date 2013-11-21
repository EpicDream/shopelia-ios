//
//  SPShopeliaManager.m
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPShopeliaManager.h"

@implementation SPShopeliaManager

+ (void)showShopeliaSDKForURL:(NSURL *)url fromViewController:(SPViewController *)viewController completion:(void (^)(void))completion
{
    // analytics
    [[SPShopeliaAnalyticsTracker sharedInstance] trackOpenSDK];
    [[SPTracesAPIClient sharedInstance] traceProductClick:[url absoluteString]];
    
    // contact shopelia SDK
    Shopelia *shopelia = [[Shopelia alloc] init];
    [viewController showLoadingView:YES];
    [shopelia prepareOrderWithProductURL:url completion:^(NSError *error) {
        if (!error)
        {
            [shopelia checkoutPreparedOrderFromViewController:viewController animated:YES completion:^{
                [viewController showLoadingView:NO];
                
                if (completion)
                    completion();
            }];
        }
        else
        {
            [viewController showLoadingView:NO];
            
            if (completion)
                completion();
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Shopelia"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }];
}

+ (void)showShopeliaSDKForURL:(NSURL *)url fromViewController:(SPViewController *)viewController
{
    [self showShopeliaSDKForURL:url fromViewController:viewController completion:nil];
}

@end
