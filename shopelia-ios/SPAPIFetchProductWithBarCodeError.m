//
//  SPAPIFetchProductWithBarCodeError.m
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAPIFetchProductWithBarCodeError.h"

@implementation SPAPIFetchProductWithBarCodeError

#pragma mark - Error management

- (BOOL)processError:(NSError *)error response:(SPHTTPResponse *)response
{
    BOOL hasError = [super processError:error response:response];
    
    if (!hasError)
    {
        NSDictionary *JSON = [response responseJSON];
        
        if (response.statusCode != 200 || !JSON || [JSON count] == 0 ||
            [[JSON objectForKey:@"urls"] count] == 0 ||
            [[JSON objectForKey:@"image_url"] length] == 0 ||
            [[JSON objectForKey:@"name"] length] == 0)
        {
            if (self.fromScanner)
                self.localizedMessage = NSLocalizedString(@"ErrorUnableToFetchThisScannedProduct", nil);
            else
                self.localizedMessage = NSLocalizedString(@"ErrorUnableToFetchThisSearchedProduct", nil);
        }
    }
    return self.hasError;
}

@end
