//
//  EditDashboardViewController.m
//  Sano
//
//  Created by Raj Gokal on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditDashboardViewController.h"
#import "EditSubstancesCell.h"
#import "AlertsViewController.h"

@implementation EditDashboardViewController

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
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    
    // Set title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Gotham Medium" size:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = @"Slide to Edit";
    [label sizeToFit];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(dismissModalViewControllerAnimated:)]; 
    self.navigationItem.rightBarButtonItem = closeButton;
    
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
    return 51;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    MyManager *sharedManager = [MyManager sharedManager];
    return [sharedManager.substances count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EditPrototype";
    
    EditSubstancesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[EditSubstancesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        MyManager *sharedManager = [MyManager sharedManager];
        Substance *current = [sharedManager.substances objectAtIndex:indexPath.row];
        //  Add Title
        UILabel *Title = [[UILabel alloc] initWithFrame:CGRectMake(17,9,168,21)];
        Title.text = [current name];
        [cell.contentView addSubview:Title];
        [Title setFont:[UIFont fontWithName:@"Gotham Medium" size:16.0]];
        [Title setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:Title];
        
        //  Add Value
        UILabel *Value = [[UILabel alloc] initWithFrame:CGRectMake(17,23,43,21)];
        NSString *displayInput = [[NSString alloc] init];
        int unitOffset;
        if ([current input]>=100){
            displayInput = @"%.0f";
            unitOffset = -7;
        }
        else if ([current input]>=10){
            displayInput = @"%.1f";
            unitOffset = -3;
        }
        else {
            displayInput = @"%.2f";
            unitOffset = -0;
        }
        Value.text = [NSString stringWithFormat:displayInput, [current input]];
        [Value setFont:[UIFont fontWithName:@"Gotham Light" size:14.0]];
        [Value setTextColor:[UIColor blackColor]];
        [Value setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:Value];
        
        //  Add Unit
        UILabel *Unit = [[UILabel alloc] initWithFrame:CGRectMake(50+unitOffset,23,122,21)];
        [Unit setText:[current unit]];
        [Unit setTextColor:[UIColor lightGrayColor]];
        [Unit setFont:[UIFont fontWithName:@"Gotham Medium" size:11.0]];
        [Unit setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:Unit];
        
        UISlider *Slider = [[UISlider alloc] initWithFrame:CGRectMake(186, 14, 114, 22)];
        [Slider setValue:[current input]];
        [Slider setMaximumValue:[current max]*2];
        [Slider setMinimumValue: [current min]/2];
        [cell.contentView addSubview:Slider];
        
        //Configure cell
        cell.row = indexPath.row;
        cell.backgroundView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        UIView* selectedBackgroundView = [ [ UIView alloc ] initWithFrame:CGRectZero ];
        cell.selectedBackgroundView = selectedBackgroundView;
        cell.selectedBackgroundView.backgroundColor = [[UIColor alloc] initWithRed:193.0 / 255 green:243.0 / 255 blue:255.0 / 255 alpha:1.0];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)revealAlerts:(id)sender {
    // Create the root view controller for the navigation controller
    // The new view controller configures a Cancel and Done button for the
    // navigation bar.
    AlertsViewController *newViewController = [[AlertsViewController alloc]init];
    
    // Create the navigation controller and present it.
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:newViewController];
    [self presentViewController:navigationController animated:YES completion: nil];
}

@end
