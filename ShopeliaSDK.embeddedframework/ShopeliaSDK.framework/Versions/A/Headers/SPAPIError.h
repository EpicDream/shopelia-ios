//
//  SPAPIError.h
//  ShopeliaSDK
//
//  Created by Nicolas on 19/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPHTTPResponse.h"
#import "SPFunctions.h"

@interface SPAPIError : NSObject

// inits the receiver with the given error and response
- (id)initWithError:(NSError *)error response:(SPHTTPResponse *)response;

// processes the given error and response and returns wether an error has occured
- (BOOL)processError:(NSError *)error response:(SPHTTPResponse *)response;

// returns wether the receiver has error
- (BOOL)hasError;

@property (strong, nonatomic) NSString *localizedMessage;

@end
