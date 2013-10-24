//
//  SPProductOptionValuesViewController.h
//  ShopeliaSDK
//
//  Created by Nicolas on 07/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPViewController.h"

@class SPProductOptionValuesViewController;

@protocol SPProductOptionValuesViewControllerDelegate <NSObject>

- (void)optionValuesViewController:(SPProductOptionValuesViewController *)vc
              didSelectOptionValue:(SPProductOptionValue *)optionValue
                    forOptionIndex:(NSInteger)optionIndex;

@end

@interface SPProductOptionValuesViewController : SPViewController

@property (assign, nonatomic) NSInteger optionIndex;
@property (strong, nonatomic) NSArray *optionValues;
@property (strong, nonatomic) SPProductOptionValue *currentOptionValue;
@property (weak, nonatomic) id <SPProductOptionValuesViewControllerDelegate> delegate;

@end
