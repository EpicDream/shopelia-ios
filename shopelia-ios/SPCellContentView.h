//
//  SPCellContentView.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/20/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CellPositionTop,
    CellPositionMiddle,
    CellPositionBottom,
    CellPositionSingle
} CellPosition;

@interface SPCellContentView : UIView

@property (assign) CellPosition position;

@end
