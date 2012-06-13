//
//  SanoDashboardViewController.h
//  Sano
//
//  Created by Raj Gokal on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Substance.h"
#import "SanoSubstanceViewController.h"
#import "SubstancesCell.h"
#import "EditDashboardViewController.h"
#import "MyManager.h"

@interface SanoDashboardViewController : UITableViewController <UITableViewDelegate>

@property (nonatomic, strong) Substance *currentSubstance;
@property (nonatomic, weak) Metric *currentMetric;

@end
