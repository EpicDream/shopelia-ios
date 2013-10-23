//
//  errorViewController.h
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/27/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface errorViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *errorText;
@property (strong, nonatomic) IBOutlet UIButton *errorBtn;
@property (strong, nonatomic) NSString *errorString;

- (IBAction)errorBtnAction:(id)sender;

@end
