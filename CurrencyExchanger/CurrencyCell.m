//
//  CurrencyCell.m
//  CurrencyExchanger
//
//  Created by Jon Kotowski on 2/26/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import "CurrencyCell.h"

@implementation CurrencyCell

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

@end
