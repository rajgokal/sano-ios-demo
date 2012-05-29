//
//  SanoSubstanceViewController.m
//  Sano
//
//  Created by Raj Gokal on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SanoSubstanceViewController.h"

@implementation SanoSubstanceViewController

@synthesize currentSubstance;
@synthesize currentImage;
@synthesize graph = _graph;

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return (NSUInteger) 51;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot 
                     field:(NSUInteger)fieldEnum 
               recordIndex:(NSUInteger)index 
{
    double val = (index/5.0)-5;
    
    if(fieldEnum == CPTScatterPlotFieldX)
    { return [NSNumber numberWithDouble:val]; }
    else
    { 
        if(plot.identifier == @"X Squared Plot")
        { return [NSNumber numberWithDouble:val*val]; }
        else
        { return [NSNumber numberWithDouble:1/val]; }
    }
}
 
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
    [super viewDidLoad];
    
    self.graph = [[CPTXYGraph alloc] initWithFrame: self.view.bounds];
    
    CPTGraphHostingView *hostingView = (CPTGraphHostingView *)self.view;
    hostingView.hostedGraph = self.graph;
    self.graph.paddingLeft = 20.0;
    self.graph.paddingTop = 20.0;
    self.graph.paddingRight = 20.0;
    self.graph.paddingBottom = 20.0;
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-6) length:CPTDecimalFromFloat(12)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-5) length:CPTDecimalFromFloat(30)];

    
    CPTScatterPlot *xSquaredPlot = [[CPTScatterPlot alloc]
                                    initWithFrame:plotSpace.accessibilityFrame];
    xSquaredPlot.identifier = @"X Squared Plot";
    xSquaredPlot.dataSource = self;

    CPTPlotSymbol *greenCirclePlotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    greenCirclePlotSymbol.fill = [CPTFill fillWithColor:[CPTColor greenColor]];
    greenCirclePlotSymbol.size = CGSizeMake(2.0, 2.0);
    xSquaredPlot.plotSymbol = greenCirclePlotSymbol;
    
    [self.graph addPlot:xSquaredPlot];
    
}

- (void)viewDidUnload
{
//    [self setCurrentMolecule:nil];
    [self setCurrentImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
