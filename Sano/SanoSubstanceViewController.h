//
//  SanoSubstanceViewController.h
//  Sano
//
//  Created by Raj Gokal on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Substance.h"
#import "MyManager.h"

@interface SanoSubstanceViewController : UIViewController

@property (nonatomic, strong) Substance *currentSubstance;

@property (weak, nonatomic) IBOutlet UIImageView *currentImage;

@end