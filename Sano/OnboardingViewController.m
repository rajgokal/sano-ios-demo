//
//  OnboardingViewController.m
//  Sano
//
//  Created by Raj Gokal on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OnboardingViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "EditDashboardViewController.h"

@implementation OnboardingViewController

@synthesize firstName;
@synthesize lastName;
@synthesize email;
@synthesize password;
@synthesize height;
@synthesize weight;
@synthesize gender;
@synthesize diseaseDepression;
@synthesize diseaseAnemia;
@synthesize diseaseAsthma;
@synthesize diseaseChronicKidney;
@synthesize diseaseCoronaryArtery;
@synthesize diseaseHypertension;
@synthesize diseaseDiabetes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL) getDiseaseDiabetes {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Bokeh.png"]];
    [super viewDidLoad];
    [firstName setDelegate:self];
    [lastName setDelegate:self];
    [email setDelegate:self];
    [password setDelegate:self];
    [height setDelegate:self];
    [weight setDelegate:self];
    UIImage *image = [UIImage imageNamed:@"Logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake(0, 0, 81, 22)];
    self.navigationItem.titleView = imageView;
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(revealSettings:)]; 
    self.navigationItem.rightBarButtonItem = settingsButton;
    
    // creating custom button properties
    UIFont *buttonFont = [UIFont fontWithName:@"Gotham Medium" size:17.0];
    UIColor *buttonColorDefault = [UIColor blackColor];
    UIColor *buttonColorHighlight = [UIColor blackColor];
    UIImage *btn = [UIImage imageNamed:@"Button.png"];
    UIImage *btnh = [UIImage imageNamed:@"ButtonHighlighted.png"];
    
    // building the buttons
    UIButton *Button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button1 addTarget:self action:@selector(pushMetrics:) forControlEvents:UIControlEventTouchUpInside];
    [Button1 setTitle:@"Cyclist" forState:UIControlStateNormal];
    [Button1 setFrame:CGRectMake(20, 57, 280, 87)];
    [Button1 setBackgroundImage:btn forState:UIControlStateNormal];
    [Button1 setBackgroundImage:btnh forState:UIControlStateHighlighted];
    
    [Button1.titleLabel setFont:buttonFont];
    [Button1 setTitleColor:buttonColorDefault forState:UIControlStateNormal];
    [Button1 setTitleColor:buttonColorHighlight forState:UIControlStateHighlighted];
    [Button1 addTarget:self action:@selector(pushMetrics:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:Button1];
    
    UIButton *Button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button2 addTarget:self action:@selector(pushMetrics:) forControlEvents:UIControlEventTouchUpInside];
    [Button2 setTitle:@"Chronic Kidney Disease" forState:UIControlStateNormal];
    [Button2 setFrame:CGRectMake(20, 157, 280, 87)];
    [Button2 setBackgroundImage:btn forState:UIControlStateNormal];
    [Button2 setBackgroundImage:btnh forState:UIControlStateHighlighted];
    
    [Button2.titleLabel setFont:buttonFont];
    [Button2 setTitleColor:buttonColorDefault forState:UIControlStateNormal];
    [Button2 setTitleColor:buttonColorHighlight forState:UIControlStateHighlighted];
    [Button2 addTarget:self action:@selector(pushMetrics:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:Button2];

    UIButton *Button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button3 addTarget:self action:@selector(pushMetrics:) forControlEvents:UIControlEventTouchUpInside];
    [Button3 setTitle:@"Fertility" forState:UIControlStateNormal];
    [Button3 setFrame:CGRectMake(20, 257, 280, 87)];
    [Button3 setBackgroundImage:btn forState:UIControlStateNormal];
    [Button3 setBackgroundImage:btnh forState:UIControlStateHighlighted];
    
    [Button3.titleLabel setFont:buttonFont];
    [Button3 setTitleColor:buttonColorDefault forState:UIControlStateNormal];
    [Button3 setTitleColor:buttonColorHighlight forState:UIControlStateHighlighted];
    [Button3 addTarget:self action:@selector(pushMetrics:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:Button3];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segueFromUserInfo"]) {
        
        PFUser *currentUser = [PFUser currentUser];
        
        if (currentUser) {
//            NSString *emailField = self.email.text;
//            if ([emailField isEqualToString:@""]) emailField = @"john@sano.com";
//            NSString *passwordField = self.password.text;
//            if ([passwordField isEqualToString:@""]) passwordField = @"patientpasswordsano";
//            
//            currentUser.username = emailField;
//            currentUser.password = passwordField;
//            currentUser.email = emailField;
//            
//            [currentUser saveEventually];
        }
        else {
//            PFUser *user = [PFUser user];
            
//            NSString *emailField = self.email.text;
//            if ([emailField isEqualToString:@""]) emailField = @"john@sano.com";
//            NSString *passwordField = self.password.text;
//            if ([passwordField isEqualToString:@""]) passwordField = @"patientpasswordsano";
//            
//            user.username = @"john@sano.com";
//            user.password = @"patientpasswordsano";
//            user.email = @"john@sano.com";
            [PFUser logInWithUsername:@"john@sano.com" password:@"patientpasswordsano"];
        }
        
    }
    else {
        PFUser *currentUser = [PFUser currentUser];
        
        [currentUser setObject:[sender currentTitle] forKey:@"userType"];
        [currentUser saveEventually];
    }
}

#pragma mark Text Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    /*
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
     */
    [textField resignFirstResponder];
    
    return YES;
}

//-(IBAction)switchToNewView:(id)sender {
//    if (MetricsViewController == nil) {
//        MetricsViewController *MetricsViewController = [[MetricsViewController alloc] initWithNibName:@"MetricsViewController" bundle:[NSBundle mainBundle];
//        self.newViewController = MetricsViewController;
//    }
//    
//    //How you reference your navigation controller will probably be a little different
//    [self.navigationController pushViewController:self.MetricsViewController animated:YES];
//}

- (void)pushMetrics:(id)sender {
    // Create the root view controller for the navigation controller
    // The new view controller configures a Cancel and Done button for the
    // navigation bar.
    MetricsViewController *newViewController = [[MetricsViewController alloc]init];
    [self.navigationController pushViewController:newViewController animated:YES];
    PFUser *currentUser = [PFUser currentUser];
    [currentUser setObject:[sender currentTitle] forKey:@"userType"];
    [currentUser saveEventually];
}

- (void)revealSettings:(id)sender {
    // Create the root view controller for the navigation controller
    // The new view controller configures a Cancel and Done button for the
    // navigation bar.
    EditDashboardViewController *newViewController = [[EditDashboardViewController alloc]init];
    
    // Create the navigation controller and present it.
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:newViewController];
    [self presentViewController:navigationController animated:YES completion: nil];
}

@end
