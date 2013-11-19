//
//  SPChatCollectionMessage.h
//  shopelia-ios
//
//  Created by Nicolas on 15/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatMessage.h"
#import "SPInspirationalCollection.h"

@interface SPChatCollectionMessage : SPChatMessage

@property (strong, nonatomic) SPInspirationalCollection *collection;

@end
