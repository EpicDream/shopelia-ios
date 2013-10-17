//
//  overlayView.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/10/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASAPIClient.h"


@interface overlayView : UIView <UISearchBarDelegate, UITableViewDataSource,UITableViewDelegate>

@property (assign, nonatomic) CGRect scanCrop;

@property (strong, nonatomic) ASAPIClient *apiClient;
@property (strong, nonatomic) ASRemoteIndex *index ;

@property (strong, nonatomic) UITableView *tableview;
@property (strong, nonatomic) NSArray *results;
@end
