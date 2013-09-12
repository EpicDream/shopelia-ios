//
//  productViewController.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/11/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "productViewController.h"

@interface productViewController ()

@end

@implementation productViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *logo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"logo-word.png" ]];
    self.navigationItem.titleView = logo ;
    UIView *view = self.contentView;
    view.layer.cornerRadius =  8.0;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
