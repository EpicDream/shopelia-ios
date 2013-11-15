//
//  SPUUIDManager.h
//  ShopeliaSDK
//
//  Created by Nicolas on 12/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPSingletonObject.h"

@interface SPUUIDManager : SPSingletonObject

// returns the current UUID
- (NSString *)currentUUID;

@end
