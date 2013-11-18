//
//  SPChatConversationViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 12/11/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPChatConversationViewController.h"
#import "SPPushNotificationsPermissionViewController.h"
#import "SPPushNotificationsPreferencesManager.h"
#import "SPChatTextMessageTableViewCell.h"
#import "SPChatSenderProductMessageTableViewCell.h"
#import "SPChatSenderCollectionMessageTableViewCell.h"
#import "SPChatAPIClient.h"
#import "SPChatTextMessage.h"
#import "SPPushNotificationsPermissionViewController.h"
#import "SPShopeliaManager.h"
#import "SPInspirationalCollectionProductsViewController.h"

@interface SPChatConversationViewController () <UITableViewDataSource, UITableViewDelegate, SPPushNotificationsPermissionViewControllerDelegate>
@property (weak, nonatomic) IBOutlet SPTextField *messageTextField;
@property (weak, nonatomic) IBOutlet SPView *messageView;
@property (weak, nonatomic) IBOutlet SPButton *sendButton;
@property (strong, nonatomic) NSTimer *pushStepsViewTimer;
@property (copy, nonatomic) NSArray *messages;
@end

@implementation SPChatConversationViewController

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SHOW_INSPIRATIONAL_COLLECTION_PRODUCTS"])
    {
        SPInspirationalCollectionProductsViewController *vc = (SPInspirationalCollectionProductsViewController *)segue.destinationViewController;
        vc.collection = sender;
    }
}

#pragma mark - Actions

- (void)validateViewController
{
    [self destroyPushStepsTimer];
    [self.delegate chatConversationViewControllerDidEndConversation:self];
    
    [super validateViewController];
}

+ (void)showChatConversation:(BOOL)force
{
    // show chat view conversation, if needed
    UIApplication *application = [UIApplication sharedApplication];
    
    if (application.applicationState != UIApplicationStateActive || force)
    {
        SPNavigationController *navigationController = (SPNavigationController *)application.keyWindow.rootViewController;
        if ([navigationController isKindOfClass:[SPNavigationController class]])
        {
            SPContainerViewController *viewController = (SPContainerViewController *)navigationController.topViewController;
            if ([viewController isKindOfClass:[SPContainerViewController class]])
            {
                if (viewController.showsChat)
                {
                    [viewController showChatConversationViewController];
                }
            }
        }
    }
}

- (IBAction)sendButtonTouched:(id)sender
{
    if (![[SPPushNotificationsPreferencesManager sharedInstance] userAlreadyGrantedPushNotificationsPermission])
    {
        // show push notifications permissions
        SPNavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"SPPushNotificationsPermissionNavigationController"];
        SPPushNotificationsPermissionViewController *pushViewController = (SPPushNotificationsPermissionViewController *)navigationController.topViewController;
        pushViewController.delegate = self;
        [self presentViewController:navigationController animated:YES completion:nil];
        return ;
    }

    // send current text message
    [self sendTextMessageWithCurrentText];
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

- (void)messageTextFieldDidChange:(SPTextField *)textField
{
    [self updateSendButtonState];
}

- (void)sendTextMessageWithCurrentText
{
    // create new message
    SPChatTextMessage *message = [[SPChatTextMessage alloc] init];
    message.message = self.messageTextField.text;
    
    // send it
    [[SPChatAPIClient sharedInstance] sendTextMessage:message];
    
    // clear message textfield text
    self.messageTextField.text = @"";
    [self updateSendButtonState];
}

#pragma mark - SPPushNotificationsPermissionViewController delegate

- (void)pushNotificationsPermissionViewControllerUserDidAcceptRemoteNotifications:(SPPushNotificationsPermissionViewController *)viewController
{
    // send current text message
    [self sendTextMessageWithCurrentText];
    
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)pushNotificationsPermissionViewControllerUserDidRefuseRemoteNotifications:(SPPushNotificationsPermissionViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SPChatAPIClient notifications

- (void)chatAPIClientDidUpdateMessageList:(NSNotification *)notification
{
    [self updateMessageListAnimated:YES];
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id message = [self.messages objectAtIndex:indexPath.row];
    
    if ([message isKindOfClass:[SPChatProductMessage class]])
    {
        SPChatProductMessage *productMessage = (SPChatProductMessage *)message;
        
        // show SDK
        [SPShopeliaManager showShopeliaSDKForURL:productMessage.URL fromViewController:self];
    }
    else if ([message isKindOfClass:[SPChatCollectionMessage class]])
    {
        SPChatCollectionMessage *collectionMessage = (SPChatCollectionMessage *)message;
        
        // show collection
        [self performSegueWithIdentifier:@"SHOW_INSPIRATIONAL_COLLECTION_PRODUCTS" sender:collectionMessage.collection];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    id message = [self.messages objectAtIndex:indexPath.row];
    
    if ([message isKindOfClass:[SPChatProductMessage class]] ||
        [message isKindOfClass:[SPChatCollectionMessage class]])
        return YES;
    return NO;
}

#pragma mark - UITableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id message = [self.messages objectAtIndex:indexPath.row];
    SPChatMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[message displayCellIdentifier]];
    
    [cell configureWithChatMessage:message];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id message = [self.messages objectAtIndex:indexPath.row];
    
    // fixed heights
    if ([message isKindOfClass:[SPChatProductMessage class]] ||
        [message isKindOfClass:[SPChatCollectionMessage class]])
        return 200.0f;
    
    // dynamic heights
    if ([message isKindOfClass:[SPChatTextMessage class]])
    {
        SPChatTextMessage *textMessage = (SPChatTextMessage *)message;
        return [SPChatTextMessageTableViewCell heightForMessage:textMessage.message];
    }
    return 100.0f;
}

#pragma mark - Interface

- (void)setupUI
{
    [super setupUI];
    
    self.messageTextField.placeholder = NSLocalizedString(@"SendAMessageToGeorge", nil);
    [self.sendButton setTitle:NSLocalizedString(@"Send", nil) forState:UIControlStateNormal];
    self.messageTextField.font = [UIFont fontWithName:self.messageTextField.font.fontName size:14.0f];
    self.sendButton.titleLabel.font = [UIFont fontWithName:self.sendButton.titleLabel.font.fontName size:14.0f];

    [self.tableView registerNib:[UINib nibWithNibName:@"SPChatSenderTextMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"SPChatSenderTextMessageTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SPChatReceiverTextMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"SPChatReceiverTextMessageTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SPChatSenderProductMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"SPChatSenderProductMessageTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SPChatSenderCollectionMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"SPChatSenderCollectionMessageTableViewCell"];
    
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.showsVerticalScrollIndicator = YES;
    
    [self.errorMessageView.actionButton removeFromSuperview];
    [self.errorMessageView.messageLabel setText:NSLocalizedString(@"PushNotificationsArentEnabled", nil)];
}

- (void)setupUIForContentView
{
    [super setupUIForContentView];
    
    self.messageView.hidden = NO;
    self.tableView.hidden = NO;
}

- (void)setupUIForErrorMessageView
{
    [super setupUIForErrorMessageView];
    
    self.messageView.hidden = YES;
    self.tableView.hidden = YES;
}

- (void)setupUIForWaitingMessageView
{
    [super setupUIForWaitingMessageView];
    
    self.messageView.hidden = YES;
    self.tableView.hidden = YES;
}

- (void)updateSendButtonState
{
    NSString *message = [SPDataConvertor stringByTrimmingString:self.messageTextField.text];
    
    self.sendButton.enabled = (message.length > 0);
}

- (void)updateMessageListAnimated:(BOOL)animated
{
    // get all messages
    NSUInteger beforeCount = self.messages.count;
    self.messages = [[SPChatAPIClient sharedInstance] allMessages];
    
    // reload table view
    [self.tableView reloadData];
    
    // scroll to bottom, if needed
    if (self.messages.count != beforeCount && self.messages.count > 0 && self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        [self scrollTableViewToBottomAnimated:animated];
    }
}

- (void)scrollTableViewToBottomAnimated:(BOOL)animated
{
    [self.tableView setContentOffset:CGPointMake(0.0f, self.tableView.contentSize.height - self.tableView.frame.size.height + self.tableView.contentInset.bottom) animated:animated];
}

- (void)updatePushNotificationStepsVisibility
{
    // destroy timer
    [self destroyPushStepsTimer];
    
    if ([[SPPushNotificationsPreferencesManager sharedInstance] userEnabledRequiredRemoteNotificationType])
    {
        [self setupUIForContentView];
    }
    else if ([[SPPushNotificationsPreferencesManager sharedInstance] userAlreadyGrantedPushNotificationsPermission])
    {
        [self setupUIForErrorMessageView];
        
        self.pushStepsViewTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updatePushNotificationStepsVisibility) userInfo:nil repeats:NO];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    [super keyboardWillBeHidden:notification];

    // move elements
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [UIView animateWithDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.messageView.transform = CGAffineTransformIdentity;
    }];
}

- (void)keyboardWillBeShown:(NSNotification *)notification
{
    [super keyboardWillBeShown:notification];
    
    // get keyboard size
    NSDictionary *info = [notification userInfo];
    CGRect keyboardBounds = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    // move elements
    [self.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, keyboardBounds.size.height, 0.0f)];
    if (self.tableView.contentSize.height > (self.tableView.frame.size.height - keyboardBounds.size.height))
        [self scrollTableViewToBottomAnimated:YES];
    [UIView animateWithDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.messageView.transform = CGAffineTransformMakeTranslation(0.0f, -keyboardBounds.size.height);
    }];
}

#pragma mark - Lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatAPIClientDidUpdateMessageList:) name:SPChatAPIClientMessageListUpdatedNotification object:nil];
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
    if ([[SPPushNotificationsPreferencesManager sharedInstance] userAlreadyGrantedPushNotificationsPermission])
        [[SPPushNotificationsPreferencesManager sharedInstance] registerForRemoteNotifications];
    
    // fetch new message
    [[SPChatAPIClient sharedInstance] fetchNewMessages];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self destroyPushStepsTimer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateMessageListAnimated:NO];
    [self updateSendButtonState];
    
    // listen for message textfield changes
    [self.messageTextField addTarget:self action:@selector(messageTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPChatAPIClientMessageListUpdatedNotification object:nil];
    
    // stop listening for message textfield changes
    [self.messageTextField removeTarget:self action:@selector(messageTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

@end
