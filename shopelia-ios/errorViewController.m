//
//  errorViewController.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/27/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "errorViewController.h"

@interface errorViewController ()

@end

@implementation errorViewController

@synthesize errorString;

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
    self.navigationItem.hidesBackButton = YES;
    UIImageView *logo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"logo-word.png" ]];
    self.navigationItem.titleView = logo ;
    self.errorText.text = self.errorString;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)errorBtnAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
