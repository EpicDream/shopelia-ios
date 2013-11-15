//
//  SPChatProductMessage.h
//  shopelia-ios
//
//  Created by Nicolas on 15/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatMessage.h"

@interface SPChatProductMessage : SPChatMessage

@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDecimalNumber *price;
@property (strong, nonatomic) NSURL *URL;

@end
