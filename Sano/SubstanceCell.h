//
//  SubstanceCell.h
//  Sano
//
//  Created by Raj Gokal on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubstanceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UIImageView *Icon;
@property (weak, nonatomic) IBOutlet UILabel *Value;
@property (weak, nonatomic) IBOutlet UILabel *Unit;
@property (weak, nonatomic) IBOutlet UILabel *State;
@property (weak, nonatomic) IBOutlet UILabel *StateStatus;

@end
