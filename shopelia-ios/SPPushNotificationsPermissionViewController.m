//
//  SPPushNotificationsPermissionViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 12/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPPushNotificationsPermissionViewController.h"
#import "SPPushNotificationsPreferencesManager.h"

@interface SPPushNotificationsPermissionViewController ()
@property (weak, nonatomic) IBOutlet SPLabel *helloLabel;
@property (weak, nonatomic) IBOutlet SPButton *backButton;
@property (weak, nonatomic) IBOutlet SPButton *acceptButton;
@end

@implementation SPPushNotificationsPermissionViewController

#pragma mark - Actions

- (IBAction)yesButtonTouched:(id)sender
{
    // mark already_asked
    [[SPPushNotificationsPreferencesManager sharedInstance] markPushNotificationsAsGranted];

    [self.delegate pushNotificationsPermissionViewControllerUserDidAcceptRemoteNotifications:self];
}

- (IBAction)noButtonTouched:(id)sender
{
    [self.delegate pushNotificationsPermissionViewControllerUserDidRefuseRemoteNotifications:self];
}

#pragma mark - Lifecycle

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

    self.helloLabel.text = NSLocalizedString(@"PleaseAuthorisePushNotifications", nil);
    [self.backButton setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateNormal];
    [self.acceptButton setTitle:NSLocalizedString(@"IAccept", nil) forState:UIControlStateNormal];
    [self.backButton setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateHighlighted];
    [self.acceptButton setTitle:NSLocalizedString(@"IAccept", nil) forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
