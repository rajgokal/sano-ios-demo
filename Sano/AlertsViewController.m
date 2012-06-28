//
//  AlertsViewController.m
//  Sano
//
//  Created by Raj Gokal on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AlertsViewController.h"
#import "AlertsCell.h"
#import "MyManager.h"
#import "Substance.h"

@implementation AlertsViewController

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
    return [sharedManager.alerts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AlertPrototype";
    
    AlertsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AlertsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    MyManager *sharedManager = [MyManager sharedManager];
    Substance *current = [sharedManager.alerts objectAtIndex:([sharedManager.alerts count] - indexPath.row - 1)];
    NSString *aboveBelow = [[NSString alloc]init];
    if (current.input > current.max)
        aboveBelow = @"above";
    else aboveBelow = @"below";

    //  Add Alert
    UILabel *Alert = [[UILabel alloc] initWithFrame:CGRectMake(6,3,308,21)];
    [Alert setTextAlignment:UITextAlignmentLeft];
    [Alert setText:[NSString stringWithFormat:@"%@ level %@ target",current.name, aboveBelow]];
    [Alert setTextColor:[current colorGrabber]];
    [Alert setFont:[UIFont fontWithName:@"Gotham Medium" size:15.0]];
    [Alert setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:Alert];
    
    //  Add Value
    UILabel *Value = [[UILabel alloc] initWithFrame:CGRectMake(6,21,80,21)];
    NSString *displayInput = [[NSString alloc] init];
    if ([current input]>=100)
        displayInput = @"%.0f";
    else if ([current input]>=10)
        displayInput = @"%.1f";
    else
        displayInput = @"%.2f";
    Value.text = [NSString stringWithFormat:displayInput, [current input]];
    [Value setFont:[UIFont fontWithName:@"Gotham Light" size:14.0]];
    [Value setTextColor:[UIColor blackColor]];
    [Value setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:Value];

    //  Add Unit
    UILabel *Unit = [[UILabel alloc] initWithFrame:CGRectMake(39,21,80,21)];
    [Unit setText:[current unit]];
    [Unit setTextColor:[UIColor lightGrayColor]];
    [Unit setFont:[UIFont fontWithName:@"Gotham Light" size:11.0]];
    [Unit setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:Unit];
    
    // Add TimeStamp
    UILabel *TimeStamp = [[UILabel alloc]initWithFrame:CGRectMake(173, 21, 135, 21)];
    [TimeStamp setTextAlignment:UITextAlignmentRight];
    [TimeStamp setFont:[UIFont fontWithName:@"Gotham Light" size:11.0]];
    [TimeStamp setTextColor:[UIColor lightGrayColor]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    NSString *stringFromDate = [formatter stringFromDate:[current timeStamp]];
    [TimeStamp setText:stringFromDate];
    [cell.contentView addSubview:TimeStamp];
    
    // Add Suggestion
    UILabel *Suggestion = [[UILabel alloc]initWithFrame:CGRectMake(6, 40, 308, 60)];
    [Suggestion setFont:[UIFont fontWithName:@"Gotham Light" size:11.0]];
    [Suggestion setTextColor:[UIColor grayColor]];
    [Suggestion setText:[current suggestionGrabber]];
    [Suggestion setLineBreakMode:UILineBreakModeWordWrap];
    [Suggestion setNumberOfLines:4];
    [cell.contentView addSubview:Suggestion];
    
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    UIView* backgroundView = [ [ UIView alloc ] initWithFrame:CGRectZero ];
    backgroundView.backgroundColor = [ UIColor whiteColor ];
    UIView* selectedBackgroundView = [ [ UIView alloc ] initWithFrame:CGRectZero ];
    cell.backgroundView = backgroundView;
    cell.selectedBackgroundView = selectedBackgroundView;
    cell.selectedBackgroundView.backgroundColor = [[UIColor alloc] initWithRed:193.0 / 255 green:243.0 / 255 blue:255.0 / 255 alpha:1.0];
    
    cell.row = indexPath.row;
    
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

@end
