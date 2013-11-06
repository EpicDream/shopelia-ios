//
//  SPAPIFetchProductPricesError.m
//  shopelia-ios
//
//  Created by Nicolas on 28/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAPIFetchProductPricesError.h"

@implementation SPAPIFetchProductPricesError

#pragma mark - Error management

- (BOOL)processError:(NSError *)error response:(SPHTTPResponse *)response
{
    BOOL hasError = [super processError:error response:response];
    
    if (!hasError)
    {
        NSDictionary *JSON = [response responseJSON];
        
        // check errors
        if (response.statusCode != 200 || !JSON || [JSON count] == 0)
        {
            hasError = YES;
        }
        else
        {
            if (![JSON isKindOfClass:[NSArray class]])
            {
                hasError = YES;
            }
            else
            {
                for (NSDictionary *productJSON in JSON)
                {
                    if (![productJSON isKindOfClass:[NSDictionary class]] ||
                        [[productJSON objectForKey:@"ready"] boolValue] == 0)
                    {
                        hasError = YES;
                        break ;
                    }
                }
            }
        }

        if (hasError == YES)
            self.localizedMessage = NSLocalizedString(@"ErrorUnableToFindPricesForThisProductOnline", nil);
    }
    return self.hasError;
}

@end
