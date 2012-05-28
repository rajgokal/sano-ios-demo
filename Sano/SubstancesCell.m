//
//  SubstancesCell.m
//  Sano
//
//  Created by Raj Gokal on 2/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubstancesCell.h"

@implementation SubstancesCell
@synthesize Title;
@synthesize Icon;
@synthesize Value;
@synthesize Unit;
@synthesize State;
@synthesize StateStatus;

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
