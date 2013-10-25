//
//  SPProductSearchViewController.m
//  shopelia-ios
//
//  Created by Nicolas on 25/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import "SPProductSearchViewController.h"
#import "SPProductSearchCell.h"

#define TABLE_VIEW_PRODUCT_CELL_IDENFITIER @"SPProductSearchCell"

@interface SPProductSearchViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet SPLayoutView *headerView;
@property (weak, nonatomic) IBOutlet SPLayoutView *headerContainerView;
@property (weak, nonatomic) IBOutlet SPImageView *headerFieldImageView;
@property (weak, nonatomic) IBOutlet SPLabel *productTitleLabel;
@end

@implementation SPProductSearchViewController

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"SELECTED = %@", indexPath);
}

#pragma mark - UITableView data source

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
    SPProductSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_PRODUCT_CELL_IDENFITIER];
    [self customizeView:cell];
    
    return cell;
}

#pragma mark - Interface

+ (CGSize)sizeForText:(NSString *)text width:(CGFloat)width font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode;
{
    CGSize constraintSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize computedSize = CGSizeZero;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        paragraphStyle.lineSpacing = font.lineHeight;
        
        NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
        
        computedSize = [text boundingRectWithSize:constraintSize
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:@{
                                                    NSFontAttributeName : font,
                                                    NSParagraphStyleAttributeName : paragraphStyle
                                                    }
                                          context:context].size;
    }
    else
    {
        computedSize = [text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:lineBreakMode];
    }
    computedSize.height = ceil(computedSize.height);
    computedSize.width = ceil(computedSize.width);
    return computedSize;
}


- (void)setupUI
{
    [super setupUI];
    
    self.headerView.layoutPadding = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    self.headerContainerView.layoutPadding = UIEdgeInsetsMake(20.0f, 20.0f, 20.0f, 20.0f);
    self.headerContainerView.excludedLayoutSubviews = @[self.headerFieldImageView];
    self.productTitleLabel.layoutAutoresizesHeight = YES;
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.headerView.frame;
    frame.size.height = self.headerView.estimatedContentSize.height;
    self.headerView.frame = frame;
    
    self.headerFieldImageView.frame = self.headerContainerView.bounds;
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
