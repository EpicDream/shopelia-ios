//
//  SPProductOptionSelectorView.h
//  ShopeliaSDK
//
//  Created by Nicolas on 07/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPView.h"
#import "SPButton.h"
#import "SPLabel.h"
#import "SPImageView.h"

@interface SPProductOptionSelectorView : SPView

// sets the option number label text
- (void)setOptionNumber:(NSUInteger)optionNumber;

// sets the option value label text
- (void)setOptionValue:(NSString *)optionValue;

// sets the option value image
- (void)setOptionValueImage:(NSURL *)imageURL;

@property (weak, nonatomic) IBOutlet SPLabel *optionValueLabel;
@property (weak, nonatomic) IBOutlet SPButton *optionButton;
@property (weak, nonatomic) IBOutlet SPImageView *optionImageView;

@end
