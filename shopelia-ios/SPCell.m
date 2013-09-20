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

@implementation SPCell

@synthesize position;

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
    [contentView setNeedsDisplay];
    [self.contentView addSubview: contentView];

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
    NSLog(@"%f",expectedLabelSize.height);
    infoLabel.numberOfLines = lines;
    CGRect newFrame = infoLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    infoLabel.frame = newFrame;
}

@end
