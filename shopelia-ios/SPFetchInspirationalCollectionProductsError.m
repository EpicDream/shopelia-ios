//
//  SPFetchInspirationalCollectionProductsError.m
//  shopelia-ios
//
//  Created by Nicolas on 04/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPFetchInspirationalCollectionProductsError.h"

@implementation SPFetchInspirationalCollectionProductsError

#pragma mark - Error management

- (BOOL)processError:(NSError *)error response:(SPHTTPResponse *)response
{
    BOOL hasError = [super processError:error response:response];
    
    if (!hasError)
    {
        NSArray *JSON = [response responseJSON];
        
        // check errors
        if (response.statusCode != 200 || ![JSON isKindOfClass:[NSArray class]])
        {
            self.localizedMessage = NSLocalizedString(@"ErrorUnableToFetchInspirationalCollectionProducts", nil);
        }
    }
    return self.hasError;
}

@end
