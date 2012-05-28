//
//  EditSubstancesCell.h
//  Sano
//
//  Created by Raj Gokal on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditSubstancesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *Value;
@property (weak, nonatomic) IBOutlet UILabel *Unit;
@property (weak, nonatomic) IBOutlet UISlider *Slider;
@property (assign, nonatomic) int row;
-(IBAction) sliderChanged:(id) sender;

@end
