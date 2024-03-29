//
//  OnboardingViewController.h
//  Sano
//
//  Created by Raj Gokal on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SanoButton.h"
#import "MetricsViewController.h"

@interface OnboardingViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *height;
@property (strong, nonatomic) IBOutlet UITextField *weight;
@property (strong, nonatomic) IBOutlet UISegmentedControl *gender;
@property (strong, nonatomic) IBOutlet UISwitch *diseaseDepression;
@property (strong, nonatomic) IBOutlet UISwitch *diseaseAnemia;
@property (strong, nonatomic) IBOutlet UISwitch *diseaseAsthma;
@property (strong, nonatomic) IBOutlet UISwitch *diseaseChronicKidney;
@property (strong, nonatomic) IBOutlet UISwitch *diseaseCoronaryArtery;
@property (strong, nonatomic) IBOutlet UISwitch *diseaseHypertension;
@property (strong, nonatomic) IBOutlet UISwitch *diseaseDiabetes;

@end
