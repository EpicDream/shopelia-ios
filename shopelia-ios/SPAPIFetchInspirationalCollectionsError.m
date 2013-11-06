//
//  SPAPIFetchInspirationalCollectionsError.m
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPAPIFetchInspirationalCollectionsError.h"

@implementation SPAPIFetchInspirationalCollectionsError

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
            self.localizedMessage = NSLocalizedString(@"ErrorUnableToFetchInspirationalCollections", nil);
        }
    }
    return self.hasError;
}

@end
