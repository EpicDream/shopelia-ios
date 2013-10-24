//
//  SPProductOptionValueSelectorView.h
//  ShopeliaSDK
//
//  Created by Nicolas on 07/10/13.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPView.h"
#import "SPButton.h"
#import "SPImageView.h"

@interface SPProductOptionValueSelectorView : SPView

// sets the value title text
- (void)setValueTitle:(NSString *)valueTitle;

// sets the value image
- (void)setValueImage:(NSURL *)imageURL;

// marks the option value as current (different visual style)
- (void)markAsCurrent;

@property (weak, nonatomic) IBOutlet SPButton *optionButton;
@property (weak, nonatomic) IBOutlet SPImageView *optionImageView;

@end
