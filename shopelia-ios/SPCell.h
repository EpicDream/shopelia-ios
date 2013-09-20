//
//  SPCell.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/19/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCellContentView.h"


@interface SPCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *shippingInfos;
@property (strong, nonatomic) IBOutlet UILabel *soldBy;
@property (assign) CellPosition position;

- (void) updateContentView;

@end
