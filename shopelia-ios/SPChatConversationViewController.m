//
//  SPChatConversationViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 12/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatConversationViewController.h"
#import "SPPushNotificationsPermissionViewController.h"
#import "SPChatPushNotificationsStepsView.h"
#import "SPPushNotificationsPreferencesManager.h"

@interface SPChatConversationViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet SPTextField *messageTextField;
@property (weak, nonatomic) IBOutlet SPView *messageView;
@property (assign, nonatomic) CGRect initialMessageViewFrame;
@property (assign, nonatomic) CGRect initialTableViewFrame;
@property (strong, nonatomic) SPChatPushNotificationsStepsView *pushStepsView;
@property (strong, nonatomic) NSTimer *pushStepsViewTimer;
@end

@implementation SPChatConversationViewController

#pragma mark - Lazy instantiation

- (SPChatPushNotificationsStepsView *)pushStepsView
{
    if (!_pushStepsView)
    {
        _pushStepsView = [SPChatPushNotificationsStepsView instanciateFromNibInBundle:[NSBundle mainBundle]];
        [SPViewController customizeView:_pushStepsView];
    }
    return _pushStepsView;
}

#pragma mark - Actions

- (void)validateViewController
{
    [self destroyPushStepsTimer];
    [self.delegate chatConversationViewControllerDidEndConversation:self];
    
    [super validateViewController];
}

- (IBAction)sendButtonTouched:(id)sender
{
  
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    [self updatePushNotificationStepsVisibility];
}

- (void)destroyPushStepsTimer
{
    [self.pushStepsViewTimer invalidate];
    self.pushStepsViewTimer = nil;
}

#pragma mark - UITableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Coucou"];
    return cell;
}

#pragma mark - Interface

- (void)setupUI
{
    [super setupUI];
    
    self.messageTextField.placeholder = NSLocalizedString(@"SendAMessageToGeorge", nil);
}

- (void)updatePushNotificationStepsVisibility
{
    // destroy timer
    [self destroyPushStepsTimer];
    
    if ([[SPPushNotificationsPreferencesManager sharedInstance] userEnabledRequiredRemoteNotificationType])
    {
        [self.pushStepsView removeFromSuperview];
    }
    else
    {
        [self.view addSubview:self.pushStepsView];
        
        self.pushStepsViewTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updatePushNotificationStepsVisibility) userInfo:nil repeats:NO];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    [super keyboardWillBeHidden:notification];

    // move elements
    [UIView animateWithDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.messageView.frame = self.initialMessageViewFrame;
        self.tableView.frame = self.initialTableViewFrame;
    }];
}

- (void)keyboardWillBeShown:(NSNotification *)notification
{
    [super keyboardWillBeShown:notification];

    // get keyboard size
    NSDictionary *info = [notification userInfo];
    CGRect keyboardBounds = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    // move elements
    self.initialMessageViewFrame = self.messageView.frame;
    self.initialTableViewFrame = self.tableView.frame;
    [UIView animateWithDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.messageView.frame = CGRectMake(self.messageView.frame.origin.x,
                                            self.messageView.frame.origin.y - keyboardBounds.size.height,
                                            self.messageView.frame.size.width,
                                            self.messageView.frame.size.height);
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x,
                                          self.tableView.frame.origin.y,
                                          self.tableView.frame.size.width,
                                          self.tableView.frame.size.height - keyboardBounds.size.height);
    }];
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.pushStepsView.frame = self.view.bounds;
}

#pragma mark - Lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[SPBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil)
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(validateViewController)];
    
    [self updatePushNotificationStepsVisibility];
    
    // register notifications
    [[SPPushNotificationsPreferencesManager sharedInstance] registerForRemoteNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self destroyPushStepsTimer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

@end
