//
//  EditSubstancesCell.m
//  Sano
//
//  Created by Raj Gokal on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditSubstancesCell.h"
#import "MyManager.h"
#import "Substance.h"

@implementation EditSubstancesCell

@synthesize Title;
@synthesize Value;
@synthesize Unit;
@synthesize Slider;
@synthesize row;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction) sliderChanged:(id) sender{
    MyManager *sharedManager = [MyManager sharedManager];
    UISlider *slider = (UISlider *) sender;
    int progressAsInt =(int)(slider.value + 0.5f);
    NSString *newText =[[NSString alloc]
                        initWithFormat:@"%d",progressAsInt];
    self.Value.text = newText;
    Substance *substanceAtRow = [sharedManager.substances objectAtIndex:row];
    [substanceAtRow setInput:progressAsInt];
    [sharedManager.substances replaceObjectAtIndex:row withObject:substanceAtRow];
    if (substanceAtRow.input > substanceAtRow.max | substanceAtRow.input <substanceAtRow.min)
        [substanceAtRow createAlert];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
