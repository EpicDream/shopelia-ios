//
//  SPCell.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 9/19/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "SPCell.h"
#import "UIColor+Shopelia.h"
#import "UIView+Shopelia.h"
#import <OHAttributedLabel/OHASBasicHTMLParser.h>

@implementation SPCell

@synthesize position;
@synthesize shippingPrice;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) updateContentView {
    SPCellContentView *contentView = [[SPCellContentView alloc] initWithFrame:self.frame];
    contentView.position = self.position;
    [contentView setUserInteractionEnabled: NO];
    [contentView setNeedsDisplay];
    [self.contentView addSubview: contentView];
}


- (void) formatMerchantUrl: (NSDictionary *) product{
    NSMutableAttributedString *merchantUrlLabel = [[NSMutableAttributedString alloc] initWithAttributedString:[OHASBasicHTMLParser attributedStringByProcessingMarkupInString: [[NSString alloc] initWithFormat:@"<font name='Helvetica Neue Light' size='10'>Par</font> <font name='Helvetica Neue Light' size='10'><a href='%@'>%@</a></font>",[product valueForKey:@"url"],[[product objectForKey:@"merchant"] valueForKey:@"domain"]]]];
    self.soldBy.attributedText = merchantUrlLabel;
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
    self.soldBy.textAlignment = UITextAlignmentRight;
#else
    self.soldBy.textAlignment = NSTextAlignmentRight;
#endif
}

- (void) formatShipping {
    
    NSString *formatedShipping = @"<font name='Helvetica Neue Light' size='10'>Livraison </font><font name='Helvetica Neue Light' size='10'><font color='#2B9B82'>incluse</font></font>";
    NSMutableAttributedString *shippingLabel = [[NSMutableAttributedString alloc] initWithAttributedString:[OHASBasicHTMLParser attributedStringByProcessingMarkupInString: formatedShipping]];
    
    self.shippingPrice.attributedText = shippingLabel;

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
    self.shippingPrice.textAlignment = UITextAlignmentLeft;
#else
    self.shippingPrice.textAlignment = NSTextAlignmentLeft;
#endif
    //NSLog(@"%@",self.shippingPrice.attributedText);
    
}




- (void)layoutSubviews {
    [super layoutSubviews];
    UILabel *infoLabel = self.shippingInfos;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
    CGSize expectedLabelSize =  [infoLabel.text sizeWithFont:infoLabel.font
                           constrainedToSize:infoLabel.frame.size
                               lineBreakMode:UILineBreakModeWordWrap];
    int lines = expectedLabelSize.height /infoLabel.font.pointSize;
#else
    CGSize expectedLabelSize =  [infoLabel.text sizeWithFont:infoLabel.font
                                           constrainedToSize:infoLabel.frame.size
                                               lineBreakMode:NSLineBreakByWordWrapping];
    
    int lines = expectedLabelSize.height /infoLabel.font.pointSize;

#endif
    //NSLog(@"%f",expectedLabelSize.height);
    infoLabel.numberOfLines = lines;
    CGRect newFrame = infoLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    infoLabel.frame = newFrame;
}

@end
