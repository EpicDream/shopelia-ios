//
//  SPInspirationalCollection.h
//  shopelia-ios
//
//  Created by Nicolas on 31/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPInspirationalCollection : SPModelObject

@property (strong, nonatomic) NSString *UUID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *imageURL;
@property (assign, nonatomic) CGSize imageSize;

@end
