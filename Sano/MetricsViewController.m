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
    self.tableView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIImage *image = [UIImage imageNamed:@"Logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake(0, 0, 81, 22)]; 
    self.navigationItem.titleView = imageView;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    }
    MyManager *sharedManager = [MyManager sharedManager];

    NSArray *metrics;
    for (UserType *uType in [sharedManager userTypes]) {
        if ([uType.name isEqualToString:uTypeString]) {
            metrics = uType.metrics;
        }
    }
    
    Metric *current = [metrics objectAtIndex:indexPath.row];
    cell.Title.text = [current name];
    
    ADVPercentProgressBar *blueprogressBar = [[ADVPercentProgressBar alloc] initWithFrame:CGRectMake(20, 27, 267, 28) andProgressBarColor:ADVProgressBarBlue];
    
    [blueprogressBar setProgress:[current score]];
    
    [cell.contentView addSubview:blueprogressBar];
    
    CGFloat mark;
    mark=(279-15)*[current yesterday]+15;
    UIImageView *marker = [[UIImageView alloc] initWithFrame:CGRectMake(mark,27,10,33)];
    [marker setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Marker.png"]]];
    [cell.contentView addSubview:marker];
    UILabel *yesterday = [[UILabel alloc] initWithFrame:CGRectMake(mark-20,60,65,10)];
    yesterday.textColor=[UIColor blackColor];
    [yesterday setFont:[UIFont fontWithName:@"Helvetica" size:9]];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"MetricZoom"]) {
        SanoDashboardViewController *dvc = [segue destinationViewController];
        MyManager *sharedManager = [MyManager sharedManager];
        NSIndexPath *path =  [self.tableView indexPathForSelectedRow];
        int row = [path row];
        Metric *s = [sharedManager.metrics objectAtIndex:row];
        dvc.currentMetric = s;
    }
}

@end
