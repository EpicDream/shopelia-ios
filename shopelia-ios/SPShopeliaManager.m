//
//  SPShopeliaManager.m
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPShopeliaManager.h"
#import "SPAPIClient+Tracker.h"
#import "SPAPIClient+Visitor.h"

@implementation SPShopeliaManager

+ (void)showShopeliaSDKForURL:(NSURL *)url fromViewController:(SPViewController *)viewController
{
    // send view event
    SPAPIClient *client = [SPAPIV1Client sharedInstance];
    SPAPIRequest *request = [client defaultRequest];
    [request setHTTPBodyParameters:@{@"tracker" : [client tracker],
                                     @"visitor" : [client visitor],
                                     @"type" : @"click",
                                     @"urls" : @[[url absoluteString]]}];
    [request setURL:[NSURL URLWithString:@"https://www.shopelia.com/api/events"]];
    [request setHTTPMethod:@"POST"];
    [request startWithCompletion:nil];
    
    // contact shopelia SDK
    Shopelia *shopelia = [[Shopelia alloc] init];
    [viewController showLoadingView:YES];
    [shopelia prepareOrderWithProductURL:url completion:^(NSError *error) {
        if (!error)
        {
            [shopelia checkoutPreparedOrderFromViewController:viewController animated:YES completion:^{
                 [viewController showLoadingView:NO];
            }];
        }
        else
        {
            [viewController showLoadingView:NO];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Shopelia"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }];
}

@end
