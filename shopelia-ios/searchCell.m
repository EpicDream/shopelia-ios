//
//  searchCell.m
//  shopelia-ios
//
//  Created by Amine bellakrid on 10/18/13.
//  Copyright (c) 2013 Amine bellakrid. All rights reserved.
//

#import "searchCell.h"

@implementation searchCell

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
    searchCellContentView *contentView = [[searchCellContentView alloc] initWithFrame:self.frame];
    [contentView setUserInteractionEnabled: NO];
    [contentView setNeedsDisplay];
    [self.contentView addSubview: contentView];
}



@end
