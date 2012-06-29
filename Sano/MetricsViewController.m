//
//  MetricsViewController.m
//  Sano
//
//  Created by Raj Gokal on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MetricsViewController.h"
#import "MyManager.h"
#import "MetricCell.h"
#import "ADVPercentProgressBar.h"
#import <QuartzCore/QuartzCore.h>
#import "SanoDashboardViewController.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UserType.h"
#import "AlertsViewController.h"

@implementation MetricsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Bokeh.png"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIImage *image = [UIImage imageNamed:@"Logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake(0, 0, 81, 22)]; 
    self.navigationItem.titleView = imageView;
    
    UIBarButtonItem *alertsButton = [[UIBarButtonItem alloc] initWithTitle:@"Alerts" style:UIBarButtonItemStylePlain target:self action:@selector(revealAlerts:)]; 
    self.navigationItem.rightBarButtonItem = alertsButton;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

//    PFUser *currentUser = [PFUser currentUser];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    MyManager *sharedManager = [MyManager sharedManager];
    PFUser *currentUser = [PFUser currentUser];
    NSString *uTypeString = [currentUser objectForKey:@"userType"];    
    NSArray *metrics;
    for (UserType *uType in [sharedManager userTypes]) {
        if ([uType.name isEqualToString:uTypeString]) {
            metrics = uType.metrics;
        }
    }
    return metrics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Metric";
    
    PFUser *currentUser = [PFUser currentUser];
    NSString *uTypeString = [currentUser objectForKey:@"userType"];
    
    
    MetricCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MetricCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    MyManager *sharedManager = [MyManager sharedManager];

    NSArray *metrics;
    for (UserType *uType in [sharedManager userTypes]) {
        if ([uType.name isEqualToString:uTypeString]) {
            metrics = uType.metrics;
        }
    }
    
    Metric *current = [metrics objectAtIndex:indexPath.row];
    
    ADVPercentProgressBar *blueprogressBar = [[ADVPercentProgressBar alloc] initWithFrame:CGRectMake(20, 32, 267, 28) andProgressBarColor:[current score]];
    [blueprogressBar setProgress:[current score]];
    [cell.contentView addSubview:blueprogressBar];
    
    // Add cell title
    UILabel *Title = [[UILabel alloc] initWithFrame:CGRectMake(20,12,260,21)];
    Title.text = [current name];
    [Title setFont:[UIFont fontWithName:@"Gotham Medium" size:16.0]];
    [Title setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:Title];
    
    // Add marker
    CGFloat mark;
    mark=(279-15)*[current yesterday]+15;
    UIImageView *marker = [[UIImageView alloc] initWithFrame:CGRectMake(mark,32,10,33)];
    [marker setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Marker.png"]]];
    [cell.contentView addSubview:marker];

    // Add "yesterday label
    UILabel *yesterday = [[UILabel alloc] initWithFrame:CGRectMake(mark-20,65,65,10)];
    yesterday.textColor=[UIColor blackColor];
    [yesterday setFont:[UIFont fontWithName:@"Gotham Light" size:9]];
    yesterday.backgroundColor=[UIColor clearColor];
    yesterday.textAlignment = UITextAlignmentLeft;
    yesterday.text = @"YESTERDAY";
    [cell.contentView addSubview:yesterday];
    
    //    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    //    cell.backgroundColor = [UIColor whiteColor];
    //    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    //    UIView* backgroundView = [ [ UIView alloc ] initWithFrame:CGRectMake(0, 0, 277, 36)];
    //    backgroundView.backgroundColor = [ UIColor whiteColor ];
    //    cell.backgroundView = backgroundView;
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"Panel.png"]]];
    UIImageView *bgSelect = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"PanelSelect.png"]]];
    cell.backgroundView = bgView;
    
    //    UIView* selectedBackgroundView = [ [ UIView alloc ] initWithFrame:CGRectZero ];
    cell.selectedBackgroundView = bgSelect;
    //    cell.selectedBackgroundView.backgroundColor = [[UIColor alloc]initWithRed:193.0 / 255 green:243.0 / 255 blue:255.0 / 255 alpha:1.0];
    //    cell.backgroundView.layer.masksToBounds = YES;
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SanoDashboardViewController *detailViewController = [[SanoDashboardViewController alloc] init];
    
    // Return the number of rows in the section.
    MyManager *sharedManager = [MyManager sharedManager];
    PFUser *currentUser = [PFUser currentUser];
    NSString *uTypeString = [currentUser objectForKey:@"userType"];    
    NSArray *metrics;
    for (UserType *uType in [sharedManager userTypes]) {
        if ([uType.name isEqualToString:uTypeString]) {
            metrics = uType.metrics;
        }
    }
    int row = indexPath.row;
    detailViewController.currentMetric = [metrics objectAtIndex:row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ( [segue.identifier isEqualToString:@"MetricZoom"]) {
//        SanoDashboardViewController *dvc = [segue destinationViewController];
//        MyManager *sharedManager = [MyManager sharedManager];
//        PFUser *currentUser = [PFUser currentUser];
//        NSString *uTypeString = [currentUser objectForKey:@"userType"];    
//        NSArray *metrics;
//        for (UserType *uType in [sharedManager userTypes]) {
//            if ([uType.name isEqualToString:uTypeString]) {
//                metrics = uType.metrics;
//            }
//        }
//        NSIndexPath *path =  [self.tableView indexPathForSelectedRow];
//        int row = [path row];
//        Metric *s = [metrics objectAtIndex:row];
//        dvc.currentMetric = s;
//    }
//}


- (void)revealAlerts:(id)sender {
    // Create the root view controller for the navigation controller
    // The new view controller configures a Cancel and Done button for the
    // navigation bar.
    AlertsViewController *newViewController = [[AlertsViewController alloc]init];
    
    // Create the navigation controller and present it.
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newViewController];
    [self presentViewController:navigationController animated:YES completion: nil];
}

@end
