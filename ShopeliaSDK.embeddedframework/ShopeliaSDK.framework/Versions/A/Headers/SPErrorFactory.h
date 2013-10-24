//
//  SPErrorFactory.h
//  ShopeliaSDK
//
//  Created by Nicolas on 05/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPErrorCodes.h"

@interface SPErrorFactory : NSObject

// returns an custom error given a SPErrorCode
+ (NSError *)errorWithCode:(SPErrorCode)code;

@end
