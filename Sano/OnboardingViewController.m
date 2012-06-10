//
//  OnboardingViewController.m
//  Sano
//
//  Created by Raj Gokal on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OnboardingViewController.h"

@implementation OnboardingViewController

@synthesize firstName;
@synthesize lastName;
@synthesize email;
@synthesize password;
@synthesize height;
@synthesize weight;
@synthesize gender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    [super viewDidLoad];
    [firstName setDelegate:self];
    [lastName setDelegate:self];
    [email setDelegate:self];
    [password setDelegate:self];
    [height setDelegate:self];
    [weight setDelegate:self];
}

- (void)viewDidUnload
{
    [self setHeight:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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


@end
