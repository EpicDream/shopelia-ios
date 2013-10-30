//
//  SPPopableViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 25/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPPopableViewController.h"

@implementation SPPopableViewController

#pragma mark - Actions

- (void)cancelViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // configure back button
    UIImage *image = [UIImage imageNamed:@"back_arrow.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [button setImage:image forState:UIControlStateNormal];
    [button sizeToFit];
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))
        [button setFrame:CGRectMake(0, 0, 30, button.frame.size.height)];
    [button addTarget:self action:@selector(cancelViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

@end
