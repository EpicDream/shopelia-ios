//
//  productListViewController.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/18/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "productListViewController.h"
#import "SPCell.h"
#import "UIColor+Shopelia.h"
#import <ShopeliaSDK/ShopeliaSDK.h>
#import "HTTPResponse.h"
#import "SpinnerView.h"
#import "loadingView.h"
#import "UIView+Shopelia.h"
#import "errorViewController.h"
#import "SPLoadingView.h"
#import "HTTPRequest.h"

@interface productListViewController ()
@property UINib *cellNib;
@property loadingView *loadingView;
@property (strong, nonatomic) SPLoadingView *blockingView;
@end

@implementation productListViewController

@synthesize shippingPrice;
@synthesize productImageView;
@synthesize priceTableView;
@synthesize cellNib;

static const int CELL_HEIGHT = 100;

- (SPLoadingView *)blockingView
{
    if (!_blockingView)
    {
        _blockingView = [[SPLoadingView alloc] init];
    }
    return _blockingView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.cellNib = [UINib nibWithNibName:@"SPCell" bundle:nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect loaderFrame = self.contentView.frame;
    loaderFrame.size.height = 200;
    self.loadingView = [[loadingView alloc] initWithFrame:loaderFrame];
    [self.loadingView setOrigY: ([[UIScreen mainScreen] bounds].size.height  - 44 - 20 - self.loadingView.Height)/2];
    [self.view addSubview:self.loadingView];
     self.priceTableView.transform = CGAffineTransformMakeTranslation(0, self.priceTableView.Height);
}

- (void) getProductFrom: (HTTPResponse *) response {
    //NSLog(@"%@",response.responseJSON);
    NSMutableArray *urlsArray = [response.responseJSON objectForKey:@"urls"];
    //NSLog(@"%@",urls);
    if ([urlsArray count] != 0) {
        self.product = response.responseJSON;
        [self.productImageView setAsynchImageWithURL:[self.product valueForKey:@"image_url"]];
        self.separatorImageView.hidden = NO;
        self.productTitle.hidden = NO;
        self.productTitle.text =  [self.product valueForKey:@"name"];
        self.urls = urlsArray;
        [self getAllProductInfosForUrls: urlsArray
                    withCompletionBlock: ^(BOOL timeout, NSError *error, HTTPResponse *response) {
                        //NSLog(@"%@",response.responseJSON);
                        NSLog(@"%hhd", timeout);
                        
                        BOOL productsAreValid = YES;
                        NSArray* resArray = (NSArray *)response.responseJSON;
                        if (!resArray || ![resArray isKindOfClass:[NSArray class]])
                            productsAreValid = NO;
                        else
                        {
                            for (id product in resArray)
                            {
                                if ([[product objectForKey:@"versions"] count] == 0)
                                {
                                    productsAreValid = NO;
                                    break;
                                }
                            }
                        }
                        
                        
                        if (!timeout && response && [[response responseJSON] count] > 0 && productsAreValid) {
                            
                            self.products = resArray;
                            [self comparePrices];
                            [self.priceTableView reloadData];
                        } else {
                            errorViewController *errorVC = [[errorViewController alloc] initWithNibName:@"errorViewController" bundle:nil];
                            errorVC.errorString = @"Nous n'avons pas trouvé de prix pour ce produit sur Internet.";
                            [self.navigationController pushViewController:errorVC animated:YES];
                            NSLog(@"ERROR TimeOut");
                        }
                    }];
        
        
    } else {
        errorViewController *errorVC = [[errorViewController alloc] initWithNibName:@"errorViewController" bundle:nil];
        errorVC.errorString = @"Nous n'avons pas trouvé de prix pour ce produit sur Internet.";
        [self.navigationController pushViewController:errorVC animated:YES];
        NSLog(@"ERROR: NO links");
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.loadingView.superview)
    {
        
        
        [self getProductNameAndUrlsWithEAN:self.eanData withCompletionBlock:^(NSError *error, HTTPResponse *response){
            if (error == nil && [[response responseJSON] count] > 0) {
                //self.priceTableView.hidden = NO;
                self.priceTableView.contentInset = UIEdgeInsetsMake(0,0,10, 0);
                [UIView transitionWithView:self.view
                                  duration:1.0
                                   options: UIViewAnimationOptionCurveEaseInOut
                                animations:^{
                                    self.priceTableView.hidden = NO;
                                    self.priceTableView.transform = CGAffineTransformIdentity;
                                } completion:nil];
                [self getProductFrom:response];
            } else {
                errorViewController *errorVC = [[errorViewController alloc] initWithNibName:@"errorViewController" bundle:nil];
                if (self.fromScanner)
                    errorVC.errorString = @"Nous n'avons pas trouvé le produit que vous venez de scanner.";
                else
                    errorVC.errorString = @"Nous n'avons pas trouvé le produit que vous recherchez.";
                [self.navigationController pushViewController:errorVC animated:YES];
                NSLog(@"%@",error);
            }
            [self.loadingView removeFromSuperview];
            
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.products count] == 0) {
        return  1;
    } else {
        return [self.products count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    SPCell *cell = (SPCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [self.cellNib instantiateWithOwner:self options:nil];

        //[[NSBundle mainBundle] loadNibNamed:@"SPCell" owner:self options:nil];
        cell = (SPCell *)[topLevelObjects objectAtIndex:0];

                int rowsInSection = [self tableView:tableView numberOfRowsInSection:indexPath.section];
                if (rowsInSection == 1) {
                    cell.position = CellPositionSingle;
                } else {
                    if (indexPath.row == 0) {
                        cell.position = CellPositionTop;
                    } else if (indexPath.row == rowsInSection - 1) {
                        cell.position = CellPositionBottom;
                    } else {
                        cell.position = CellPositionMiddle;
                    }
                }
                [cell updateContentView];

    }
    
    if ([self.products count] == 0) {
        cell.price.hidden = YES;
        cell.shippingInfos.hidden = YES;
        cell.shippingPrice.hidden = YES;
        cell.shopeliaBtn.hidden = YES;
        cell.soldBy.hidden = YES;
        SpinnerView *spinnerView = [SpinnerView loadIntoView: cell withSize:@"small"];
        CGRect frame = spinnerView.frame;
        frame.origin.y -= 12;
        spinnerView.frame = frame;
        
        UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, cell.bounds.size.width - 40, 20)];
        [text setBackgroundColor:[UIColor clearColor]];
        [text setFont:[UIFont fontWithName:@"Helvetica-Light" size:14.0f]];
        [text setText:@"Recherche des prix et disponibilités..."];
        [text setTextAlignment:NSTextAlignmentCenter];
        [cell addSubview:text];
    } else {
        NSDictionary* prod = [self.products objectAtIndex:indexPath.row];
        NSDictionary* version = [self getVersion:prod];
        //NSLog(@"%@",version);
        // Configure the cell...
        float price = [[version valueForKey:@"price"] floatValue] + [[version valueForKey:@"price_shipping"] floatValue] - [[version valueForKey:@"cashfront_value"] floatValue] ;
        cell.price.text = [NSString stringWithFormat:@"%0.2f€" ,(round(price * 100)/100)];
        
        [cell formatMerchantUrl:prod];
        [cell formatShipping];
        cell.shippingInfos.text = [version valueForKey:@"shipping_info"];
        [cell.shopeliaBtn addTarget:self action:@selector(shopeliaInit:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
    
}

- (void)shopeliaInit:(id)sender {
    //NSLog(@"%@",@"SHOPELIA INITIALISATION");
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.priceTableView];
    NSIndexPath *indexPath = [self.priceTableView indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {
         NSDictionary *prod = [self.products objectAtIndex:indexPath.row];
        
        // send event
        NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
        NSString *shopeliApiKey = [dict valueForKey:@"ShopeliaAPIKey"] ;
        HTTPRequest *request = [[HTTPRequest alloc] init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"shopelia-ios" forKey:@"tracker"];
        [params setObject:@"click" forKey: @"action"];
        [params setObject:@[[prod valueForKey:@"url"]] forKey: @"urls"];
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
        [self.blockingView showInView:self.view];
        [shopelia prepareOrderWithProductURL:[NSURL URLWithString: [prod valueForKey:@"url"] ] completion:^(NSError *error) {
            if (!error)
            {
                [shopelia checkoutPreparedOrderFromViewController:self animated:YES completion:^{
                    [self.blockingView hide];
                }];
            }
            else
            {
                [self.blockingView hide];
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Shopelia"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
                [alert show];
            }
        }];
    }
    
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}






@end
