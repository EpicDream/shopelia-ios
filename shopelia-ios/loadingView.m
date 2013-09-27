//
//  loadingView.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/26/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "loadingView.h"
#import "UIView+Shopelia.h"
#import <OHAttributedLabel/OHASBasicHTMLParser.h>
#import <OHAttributedLabel.h>


@implementation loadingView

@synthesize spinner;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        spinner = [SpinnerView loadIntoView: self withSize:nil];

        self.opaque = NO;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [spinner offsetFrameWithDx:0 dy:-30];
    
    OHAttributedLabel *searchLabel = [[OHAttributedLabel alloc] init];
    searchLabel.Height = 50;
    searchLabel.Width = 200;
    [searchLabel setOrigX: (self.Width - searchLabel.Width)/2];
    [searchLabel setOrigY: ((self.OrigY + self.Height) -  (spinner.Height + spinner.OrigY))/2 + searchLabel.Height/2];
    
    NSMutableAttributedString *search = [[NSMutableAttributedString alloc] initWithAttributedString:[OHASBasicHTMLParser attributedStringByProcessingMarkupInString: @"<font name='HelveticaNeue-Light' size='18'>Nous recherchons les <b> meilleurs prix</b>... </font>"]];
    searchLabel.attributedText = search;
    searchLabel.backgroundColor = [UIColor clearColor];
    searchLabel.numberOfLines = 2;

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
    searchLabel.textAlignment = UITextAlignmentCenter;
    searchLabel.lineBreakMode = UILineBreakModeWordWrap;
#else
    searchLabel.textAlignment = NSTextAlignmentCenter;
    searchLabel.lineBreakMode = NSLineBreakByWordWrapping;

#endif
    
    [self addSubview:searchLabel];

}


- (void) removeFromSuperview {
    [super removeFromSuperview];
    [spinner removeSpinner];
}


@end
