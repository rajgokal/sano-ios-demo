//
//  SanoDashboardViewController.m
//  Sano
//
//  Created by Raj Gokal on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SanoDashboardViewController.h"
#import "SubstancesCell.h"
#import "MyManager.h"
#import "Metric.h"
#import "MetricCell.h"
#import "ADVPercentProgressBar.h"

@implementation SanoDashboardViewController

@synthesize currentSubstance;
@synthesize currentMetric;

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
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.tableView.separatorColor = [[UIColor alloc]initWithRed:193.0 / 255 green:243.0 / 255 blue:255.0 / 255 alpha:1.0];
    
    self.title = [currentMetric name];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.row < 1) height = 82;
    else height = 51;
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    MyManager *sharedManager = [MyManager sharedManager];
    return [sharedManager.substances count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyManager *sharedManager = [MyManager sharedManager];
    
    static NSString *ZoomCellIdentifier = @"ZoomCell";
    static NSString *MetricCellIdentifier = @"MetricCell";
    
    //    Bring in single "metric" cell
    if(indexPath.row < 1) {
        MetricCell *cell = [tableView dequeueReusableCellWithIdentifier:MetricCellIdentifier];
        cell.Title.text = [currentMetric name];
        ADVPercentProgressBar *blueprogressBar = [[ADVPercentProgressBar alloc] initWithFrame:CGRectMake(20, 27, 267, 28) andProgressBarColor:ADVProgressBarBlue];
        [blueprogressBar setProgress:[currentMetric score]];
        [cell.contentView addSubview:blueprogressBar];
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"PanelZoom.png"]]];
        cell.backgroundView = bgView;
        //        cell.selectedBackgroundView = bgView;
        cell.backgroundView.layer.masksToBounds = YES;
        cell.backgroundView.layer.cornerRadius = 0.0;
        
        
        CGFloat mark;
        mark=(279-15)*[currentMetric yesterday]+15;
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
        
        return cell;
    } else {
        
        //  Bring in "zoom" substance cells
        SubstancesCell *cell = [tableView dequeueReusableCellWithIdentifier:ZoomCellIdentifier];
        if (cell == nil) {
            cell = [[SubstancesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZoomCellIdentifier];
        }
        Substance *current = [sharedManager.substances objectAtIndex:indexPath.row-1];
        cell.Title.text = [current name];
        cell.Icon.image = [UIImage imageNamed:[current iconGrabber]];
        cell.Value.text = [NSString stringWithFormat:@"%d", [current input]];
        cell.Value.textColor = [current colorGrabber];
        cell.State.textColor = [current colorGrabber];
        cell.Unit.text = [current unit];
        cell.State.text = [current stateGrabber];
        cell.StateStatus.text = [current stateStatusGrabber];
        cell.backgroundView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        UIView* backgroundView = [ [ UIView alloc ] initWithFrame:CGRectZero ];
        backgroundView.backgroundColor = [ UIColor whiteColor ];
        cell.backgroundView = backgroundView;
        UIView* selectedBackgroundView = [ [ UIView alloc ] initWithFrame:CGRectZero ];
        cell.selectedBackgroundView = selectedBackgroundView;
        cell.selectedBackgroundView.backgroundColor = [[UIColor alloc] initWithRed:193.0 / 255 green:243.0 / 255 blue:255.0 / 255 alpha:1.0];
        
        //    for ( UIView* view in cell.contentView.subviews ) 
        
        return cell;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"ShowPhoto"]) {
    SanoSubstanceViewController *dvc = [segue destinationViewController];
    MyManager *sharedManager = [MyManager sharedManager];
    NSIndexPath *path =  [self.tableView indexPathForSelectedRow];
    int row = [path row];
    Substance *s = [sharedManager.substances objectAtIndex:row-1];
    dvc.currentSubstance = s;
    }
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

@end
