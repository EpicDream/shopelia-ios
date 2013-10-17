//
//  navigationController.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/10/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "navigationController.h"
#import "Constants.h"

@interface navigationController ()

@end

@implementation navigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    [self.navigationBar setShadowImage:[UIImage new]];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"shopelia_topbar_background_high.png"] forBarMetrics:UIBarMetricsDefault];
    else
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"shopelia_topbar_background.png"] forBarMetrics:UIBarMetricsDefault];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
