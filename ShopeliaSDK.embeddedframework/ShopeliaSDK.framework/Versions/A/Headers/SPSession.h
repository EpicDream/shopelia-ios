//
//  SPSession.h
//  ShopeliaSDK
//
//  Created by Nicolas on 19/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPSingletonObject.h"
#import "SPUser.h"

@interface SPSession : SPSingletonObject

@property (strong, nonatomic) NSString *authToken;
@property (strong, nonatomic) SPUser *user;

@end
