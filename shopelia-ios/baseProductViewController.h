//
//  baseProductViewController.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/18/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface baseProductViewController : UIViewController

@property (strong, nonatomic) NSArray* products;
@property (strong, nonatomic) NSDictionary* cheaperProduct;
@property (strong, nonatomic) NSDictionary* product;
@property (strong, nonatomic) NSMutableArray* urls;

-(void) getCheaperProduct;
-(void) getAllProductInfosForUrls: (NSMutableArray*) productUrls withCompletionBlock: (void (^)(BOOL timeout, NSError *error, id response))completionBlock;
- (NSDictionary *) getVersion: (NSDictionary *) product;
- (void) customBackButton ;
- (void) back;
- (void) comparePrices;

@end
