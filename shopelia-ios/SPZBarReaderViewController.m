//
//  SPZBarReaderViewController.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/10/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "SPZBarReaderViewController.h"
#import "HTTPRequest.h"
#import "overlayView.h"
#import "UIView+Shopelia.h"
#import "shopeliaImageView.h"
#import "loadingView.h"
#import "errorViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Constants.h"
#import "threadFactory.h"
#import "searchCell.h"
#import "HTTPRequest.h"
#import <ShopeliaSDK/ShopeliaSDK.h>


@interface SPZBarReaderViewController ()
@property UINib *searchCellNib;
@end

@implementation SPZBarReaderViewController

@synthesize SPClient;
@synthesize apiClient;
@synthesize index;
@synthesize tableview;
@synthesize results;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.searchCellNib = [UINib nibWithNibName:@"searchCell" bundle:nil];
        self.apiClient =
        [ASAPIClient apiClientWithApplicationID:@"JUFLKNI0PS" apiKey:@"03832face9510ee5a495b06855dfa38b"];
        
        self.index = [self.apiClient getIndex:@"products-feed-fr"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad]; // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *logo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"logo-word.png" ]];
    self.navigationItem.titleView = logo ;

    self.readerDelegate = self;
    self.supportedOrientationsMask = ZBarOrientationMaskAll;
    self.showsZBarControls = NO;
    self.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;

    self.wantsFullScreenLayout = NO;
    overlayView *view = [[overlayView alloc] initWithFrame:self.readerView.frame];
    
    self.tableview =[[UITableView alloc] initWithFrame:CGRectMake(0, 44, view.Width, [self.results count]* 82) style:UITableViewStylePlain];
    //self.tableview =[[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.Width, 10 * 82) style:UITableViewStylePlain];
    
    self.tableview.delegate =self;
    self.tableview.dataSource =self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [searchBar sizeToFit];
    [searchBar setHeight:44.0f];
    searchBar.translucent = NO;
    searchBar.delegate = self;
    [view addSubview:searchBar];
    [view addSubview:self.tableview];
    
    
    for(UIView *subView in searchBar.subviews) {
        if([subView conformsToProtocol:@protocol(UITextInputTraits)]) {
            [(UITextField *)subView setKeyboardAppearance: UIKeyboardAppearanceAlert];
            [(UITextField *)subView setReturnKeyType:UIReturnKeyDone];
            [(UITextField *) subView addTarget:self
        action:@selector(textFieldFinished:)
        forControlEvents:UIControlEventEditingDidEndOnExit];

        }
    }
    
    
    self.cameraOverlayView = view;
    // TODO: (optional) additional reader configuration here
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [self.scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];

   }

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    

    [self.readerView setFrameSizeWithW:self.view.bounds.size.width h:self.view.bounds.size.height - 90.0f];
    [self.cameraOverlayView setFrame:self.view.bounds];
    
    overlayView *view = (overlayView *)self.cameraOverlayView;
    CGFloat rectangleX = (self.readerView.frame.size.width - view.scanRectangleSize.width) / 2.0f;
    CGFloat rectangleY = (self.readerView.frame.size.height - view.scanRectangleSize.width) / 2.0f;    CGFloat rectangleWidth = view.scanRectangleSize.width;
    CGFloat rectangleHeight = view.scanRectangleSize.width;
    
    [self.readerView setScanCrop:CGRectMake(rectangleX / self.readerView.frame.size.width,
                                            rectangleY / self.readerView.frame.size.height,
                                            rectangleWidth / self.readerView.frame.size.width,
                                            rectangleHeight / self.readerView.frame.size.height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldFinished:(id)sender
{
     [sender resignFirstResponder];
}


#pragma Zbar Delegate Implementation

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> res =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;

    for (symbol in res) {
        break;
    }

    // vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    self.productVC = [[productListViewController alloc] initWithNibName:@"productListViewController" bundle:nil];
    self.productVC.eanData = symbol.data; 
    [self.navigationController pushViewController:self.productVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"searchCell";
    
    searchCell *cell = (searchCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [self.searchCellNib instantiateWithOwner:self options:nil];
        cell = (searchCell *)[topLevelObjects objectAtIndex:0];
        
        [cell updateContentView];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *res = [[NSMutableArray alloc] initWithArray:self.results];
    
    if ([res count] > 0) {
        cell.title.text = [[res objectAtIndex:indexPath.row] objectForKey:@"name"];
        [cell.productImageView setAsynchImageWithURL:[[res objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
    }
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *res = [[NSMutableArray alloc] initWithArray: self.results];
    NSString *product_url = [[res objectAtIndex:indexPath.row] objectForKey:@"product_url"];
    
    
    NSMutableArray *tagsArray = [[res objectAtIndex:indexPath.row] objectForKey:@"_tags"];
    NSString *tmpstring = @"ean:";
    NSRange tmprange;
    for(NSString *tag in tagsArray) {
        tmprange = [tag rangeOfString:tmpstring options:NSCaseInsensitiveSearch];
        if (tmprange.location != NSNotFound) {
            NSString *ean = [tag substringFromIndex:4];
            self.productVC = [[productListViewController alloc] initWithNibName:@"productListViewController" bundle:nil];
            self.productVC.eanData = ean;
            [self.navigationController pushViewController:self.productVC animated:YES];
            break;
        } else {
            [self requestProductFromShopeliaWithUrl:product_url];
        }
    }
    
    
    
}

-(void) requestProductFromShopeliaWithUrl: (NSString *) product_url {
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    NSString *shopeliApiKey = [dict valueForKey:@"ShopeliaAPIKey"] ;
    HTTPRequest *request = [[HTTPRequest alloc] init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:@"tracker" forKey: @"shopelia-ios-app"];
    [params setObject:@"action" forKey: @"click"];
    [params setObject:product_url forKey: @"urls"];
    [params setObject:@"false" forKey: @"uuid"];
    
    
    //NSLog(@"%@",params);
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    
    request.HTTPBody = jsonData;
    [request setValue:shopeliApiKey forHTTPHeaderField:@"X-Shopelia-ApiKey"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *url =@"https://www.shopelia.com/api/events";
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request startWithCompletion:^(NSError *error, id response) {
    }];
    
    Shopelia *shopelia = [[Shopelia alloc] init];
    [shopelia prepareOrderWithProductURL:[NSURL URLWithString: product_url] completion:^(NSError *error) {
        //NSLog(@"%@", error);
        [shopelia checkoutPreparedOrderFromViewController:self animated:YES completion:nil];
    }];

}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 82;
}

#pragma mark - Search bar delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"YES");
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}

- (BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] < 2 ) {
        NSLog(@"allo");
        self.tableview.frame = CGRectMake(0, 44, self.cameraOverlayView.Width,0);
    } else {
        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(algoliaSearch:)  userInfo:searchText repeats:NO];
    }

}

- (void) algoliaSearch: (NSTimer *) timer {
    [self.index search:[ASQuery queryWithFullTextQuery:(NSString*)[timer userInfo]]
               success:^(ASRemoteIndex *index, ASQuery *query, NSDictionary *result) {
                   self.results = [result objectForKey: @"hits"];
                   [self.tableview reloadData];
                   self.tableview.frame = CGRectMake(0, 44, self.cameraOverlayView.Width, [self.results count] * 82 );
                   
               } failure:^(ASRemoteIndex *index, ASQuery *query, NSString *errorMessage) {
                   NSLog(@"%@",errorMessage);
               }];
    
    [timer invalidate];
}






@end
