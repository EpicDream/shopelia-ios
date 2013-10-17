//
//  overlayView.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/10/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "overlayView.h"
#import "UIColor+Shopelia.h"
#import "UIView+Shopelia.h"
#import "shopeliaImageView.h"
#import "threadFactory.h"


@implementation overlayView

@synthesize apiClient;
@synthesize index;
@synthesize tableview;
@synthesize results;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.apiClient =
        [ASAPIClient apiClientWithApplicationID:@"JUFLKNI0PS" apiKey:@"03832face9510ee5a495b06855dfa38b"];
        
        self.index = [self.apiClient getIndex:@"dataflux"];
        NSLog(@"%@",self.index);
        self.opaque = NO;
        
    }
    return self;
}

- (CGSize)scanRectangleSize
{
    return CGSizeMake(290.0f, 130.0f);
}

- (void)drawRect:(CGRect)rect
{
    self.tableview =[[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.Width, [self.results count]* 82) style:UITableViewStylePlain];
    self.tableview.delegate =self;
    self.tableview.dataSource =self;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [searchBar sizeToFit];
    [searchBar setHeight:44.0f];
    searchBar.translucent = NO;
    searchBar.delegate = self;
    [self addSubview:searchBar];
    //self.tableview.tableHeaderView = searchBar ;
    
    [self addSubview:self.tableview];
    
    //Adding Bottom View
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.Height - 90, self.Width, 90)];

    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    //Adding Bar code to bottom view
    
    UIImageView *barCode = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar-code.png"]];
    [barCode setFrameOriginWithX:10.0 y:(bottomView.Height - barCode.Height)/2];
    [bottomView addSubview:barCode];
    
    
    //Adding bottom label
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(bottomView.Width/2, 0,bottomView.Width/2, bottomView.Height)];
    
    bottomLabel.font =[UIFont fontWithName:@"Helvetica Neue" size:14.0];
    bottomLabel.text = @"Centrez le code-barre dans la zone ci-dessus";
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
    bottomLabel.textAlignment = UITextAlignmentCenter;
#else
    bottomLabel.textAlignment = NSTextAlignmentCenter;
#endif
    bottomLabel.backgroundColor = [UIColor clearColor];
    bottomLabel.textColor = [UIColor shopeliaBlue];
    bottomLabel.lineBreakMode = NSLineBreakByWordWrapping;
    bottomLabel.numberOfLines = 2;
    [bottomView addSubview:bottomLabel];
    
    
    //Adding Top Border
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0, 0, self.Width, 4.0f);
    topBorder.backgroundColor = [UIColor shopeliaBlue].CGColor;
    [bottomView.layer addSublayer:topBorder];
    
    //Drawing central rectangle and transparent View
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor);
    CGContextFillRect(context, self.frame);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rectangle = CGRectMake((self.Width - self.scanRectangleSize.width) / 2, (self.Height - (self.scanRectangleSize.height)) / 2, self.scanRectangleSize.width, self.scanRectangleSize.height);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
    CGContextClearRect(context,rectangle);

    //Draw centeral blue line
    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor shopeliaLightBlue].CGColor);
    CGContextMoveToPoint(context, rectangle.origin.x, rectangle.origin.y+ rectangle.size.height/2);
    CGContextAddLineToPoint(context, rectangle.origin.x + 290, rectangle.origin.y+ rectangle.size.height/2 );
    CGContextStrokePath(context);
    
    
    //Adding Text on top of central rectangle
    UILabel *centralTextLabel = [[UILabel alloc] initWithFrame:rectangle];
    [centralTextLabel setOrigY: rectangle.origin.y - rectangle.size.height ];
    
    centralTextLabel.font =[UIFont fontWithName:@"Helvetica Neue" size:24.0];
    centralTextLabel.text = @"Profitez des prix exclusifs avec Shopelia";
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
    centralTextLabel.textAlignment = UITextAlignmentCenter;
#else
    centralTextLabel.textAlignment = NSTextAlignmentCenter;
#endif
    centralTextLabel.backgroundColor = [UIColor clearColor];
    centralTextLabel.textColor = [UIColor whiteColor];
    centralTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    centralTextLabel.numberOfLines = 2;
    [self addSubview:centralTextLabel];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSMutableArray *res = [[NSMutableArray alloc] initWithArray:self.results];

    if ([res count] > 0) {
        cell.textLabel.text = [[res objectAtIndex:indexPath.row] objectForKey:@"name"];
        dispatch_async([threadFactory backgroundImagesDispatchQueue], ^{
            NSURL *URL = [NSURL URLWithString:[[res objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
            NSData *data = [NSData dataWithContentsOfURL:URL];
            UIImage *image = [UIImage imageWithData:data];
            if (image)
            {
                dispatch_async([threadFactory mainDispatchQueue], ^{
                    cell.imageView.image = image;
                });
            }
        });

    }
    
    return cell;
    
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
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(algoliaSearch:)  userInfo:searchText repeats:NO];
       NSLog(@"allo");
}

- (void) algoliaSearch: (NSTimer *) timer {
    [self.index search:[ASQuery queryWithFullTextQuery:(NSString*)[timer userInfo]]
               success:^(ASRemoteIndex *index, ASQuery *query, NSDictionary *result) {
                   self.results = [result objectForKey: @"hits"];
                   [self.tableview reloadData];
                   self.tableview.frame = CGRectMake(0, 44, self.Width, [self.results count] * 82 );

               } failure:^(ASRemoteIndex *index, ASQuery *query, NSString *errorMessage) {
                   NSLog(@"%@",errorMessage);
               }];
    
    [timer invalidate];
}



@end
