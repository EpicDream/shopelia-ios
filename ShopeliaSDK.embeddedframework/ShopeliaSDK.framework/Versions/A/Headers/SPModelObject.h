//
//  SPModelObject.h
//  ShopeliaSDK
//
//  Created by Nicolas on 05/09/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPModelObject : NSObject

// inits the receiver with the given JSON info
- (id)initWithJSON:(NSDictionary *)json;

// configures the receiver with the given JSON infos
- (BOOL)configureWithJSON:(NSDictionary *)JSON;

// returns the JSON representation of the receiver
- (NSDictionary *)JSONReprensentation;

// returns a displayable representation of the receiver
- (NSString *)displayableRepresentation;

// returns whether the receiver is valid
- (BOOL)isValid;

@end
