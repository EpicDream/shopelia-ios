//
//  searchCell.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 10/18/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchCellContentView.h"
#import "shopeliaImageView.h"


@interface searchCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
- (void) updateContentView;
@property (strong, nonatomic) IBOutlet shopeliaImageView *productImageView;

@end
