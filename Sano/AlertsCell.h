//
//  AlertsCell.h
//  Sano
//
//  Created by Raj Gokal on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Alert;
@property (weak, nonatomic) IBOutlet UILabel *Value;
@property (weak, nonatomic) IBOutlet UILabel *Unit;
@property (weak, nonatomic) IBOutlet UILabel *TimeStamp;
@property (weak, nonatomic) IBOutlet UILabel *Suggestion;
@property (assign, nonatomic) int row;

@end