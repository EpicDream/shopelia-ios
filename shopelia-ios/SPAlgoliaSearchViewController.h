//
//  SPAlgoliaSearchViewController.h
//  shopelia-ios
//
//  Created by Nicolas on 29/10/2013.
//  Copyright (c) 2013 Shopelia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPAlgoliaSearchResult.h"

@class SPAlgoliaSearchViewController;

@protocol SPAlgoliaSearchViewControllerDelegate <NSObject>

- (void)algoliaSearchViewController:(SPAlgoliaSearchViewController *)vc didSelectSearchResult:(SPAlgoliaSearchResult *)searchResult;

@end

@interface SPAlgoliaSearchViewController : SPViewController

@property (weak, nonatomic) id <SPAlgoliaSearchViewControllerDelegate> delegate;

@end
