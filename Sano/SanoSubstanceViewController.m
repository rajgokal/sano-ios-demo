//
//  SanoSubstanceViewController.m
//  Sano
//
//  Created by Raj Gokal on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SanoSubstanceViewController.h"

@implementation SanoSubstanceViewController

@synthesize dataForPlot;
@synthesize currentSubstance;

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceUpEvent:(UIEvent *)event atPoint:(CGPoint)point {
    NSLog(@"foo");
    return true;
}

-(void) plot:(CPTPlot *)plot dataLabelWasSelectedAtRecordIndex:(NSUInteger)index {
    NSLog(@"hi");
}

-(CGPoint)plotSpace:(CPTPlotSpace *)space willDisplaceBy:(CGPoint)displacement
{
    return CGPointMake(displacement.x, 0);
}

-(CPTPlotRange *)plotSpace:(CPTPlotSpace *)space willChangePlotRangeTo:(CPTPlotRange *)newRange forCoordinate:(CPTCoordinate)coordinate
{
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
    if (coordinate == CPTCoordinateX) {
        axisSet.yAxis.orthogonalCoordinateDecimal = newRange.location;
    }
    return newRange;
}

-(double) extrema:(NSString *)extrema ForAxis:(NSString *)axis {
    NSArray *copy = [dataForPlot copy];

    NSArray *sortedCopy = [copy sortedArrayUsingComparator:^(id a, id b){
        id first = [a objectForKey:axis];
        id second = [b objectForKey:axis];
        return [first compare:second];
    }];
    if (extrema == @"max") {
        return [[sortedCopy.lastObject objectForKey:axis] doubleValue];
    }
    else {
        return [[[sortedCopy objectAtIndex:1] objectForKey:axis] doubleValue];
    }
}

-(double) minXValue {
    return [self extrema:@"min" ForAxis:@"x"];
}

-(double) minYValue {
    return [self extrema:@"min" ForAxis:@"y"];
}

-(double) maxXValue {
    return [self extrema:@"max" ForAxis:@"x"];
}

-(double) maxYValue {
    return [self extrema:@"max" ForAxis:@"y"];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add some initial data
    NSMutableArray *contentArray = [NSMutableArray arrayWithCapacity:100];
    NSUInteger i;

    NSNumber *mid = [NSNumber numberWithDouble:((currentSubstance.max - currentSubstance.min)/2)];
    NSLog([mid description]);

    [contentArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0], @"x", mid, @"y", nil]];
    self.dataForPlot = contentArray;
    
    for ( i = 0; i < 20; i++ ) {
        [self addDataPoint];        
    }

    
    // Create graph from theme
    graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
    [graph applyTheme:theme];
    CPTGraphHostingView *hostingView = (CPTGraphHostingView *)self.view;
    hostingView.collapsesLayers = NO; // Setting to YES reduces GPU memory usage, but can slow drawing/scrolling
    hostingView.hostedGraph     = graph;
    
    graph.paddingLeft   = 0.0;
    graph.paddingTop    = 0.0;
    graph.paddingRight  = 0.0;
    graph.paddingBottom = 0.0;
    
    double minX = [self minXValue];
    double minY = [self minYValue];
    double maxX = [self maxXValue];
    double maxY = [self maxYValue];
    double xLength = maxX - minX;
    double yLength = maxY - minY;

    // Setup plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    plotSpace.xRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat((float) minX - 0.5) length:CPTDecimalFromFloat((float) xLength + 2)];
    plotSpace.yRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat((float) minY - 0.5) length:CPTDecimalFromFloat((float) yLength + 1)];
    plotSpace.delegate = self;
    
    // Axes
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    x.majorIntervalLength         = CPTDecimalFromString(@"2.5");
    x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(minY - 0.3);
    x.minorTicksPerInterval       = 2;
    
    CPTXYAxis *y = axisSet.yAxis;
    y.majorIntervalLength         = CPTDecimalFromString(@"0.5");
    y.minorTicksPerInterval       = 5;
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    y.labelOffset                 = -35;
    y.delegate             = self;
    
    // Create a blue plot area
    CPTScatterPlot *boundLinePlot  = [[CPTScatterPlot alloc] init];
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit        = 1.0f;
    lineStyle.lineWidth         = 3.0f;
    lineStyle.lineColor         = [CPTColor blueColor];
    boundLinePlot.dataLineStyle = lineStyle;
    boundLinePlot.identifier    = @"Blue Plot";
    boundLinePlot.dataSource    = self;
    boundLinePlot.interpolation = CPTScatterPlotInterpolationCurved;
    [graph addPlot:boundLinePlot];
    
    // Create the acceptable threshold guide
    CPTFill *fill = [CPTFill fillWithColor:[CPTColor grayColor]];
    CPTPlotRange *fillRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble([mid doubleValue] - 0.2) length:CPTDecimalFromDouble([mid doubleValue] + 0.2)];
    
    [y addBackgroundLimitBand:[CPTLimitBand limitBandWithRange:fillRange fill:fill]];
    
    // Do a blue gradient
//    CPTColor *areaColor1       = [CPTColor colorWithComponentRed:0.3 green:0.3 blue:1.0 alpha:0.8];
//    CPTGradient *areaGradient1 = [CPTGradient gradientWithBeginningColor:areaColor1 endingColor:[CPTColor clearColor]];
//    areaGradient1.angle = -90.0f;
//    CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient1];
//    boundLinePlot.areaFill      = areaGradientFill;
//    boundLinePlot.areaBaseValue = [[NSDecimalNumber zero] decimalValue];
    
    // Add plot symbols
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor blackColor];
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor blueColor]];
    plotSymbol.lineStyle     = symbolLineStyle;
    plotSymbol.size          = CGSizeMake(1.0, 1.0);
    boundLinePlot.plotSymbol = plotSymbol;
    
    // Begin Green plot
    
    // Create a green plot area
//    CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
//    lineStyle                        = [CPTMutableLineStyle lineStyle];
//    lineStyle.lineWidth              = 3.f;
//    lineStyle.lineColor              = [CPTColor greenColor];
//    dataSourceLinePlot.dataLineStyle = lineStyle;
//    dataSourceLinePlot.identifier    = @"Green Plot";
//    dataSourceLinePlot.dataSource    = self;
//    dataSourceLinePlot.interpolation = CPTScatterPlotInterpolationCurved;
    
    // Add plot symbols
//    CPTMutableLineStyle *greenLineStyle = [CPTMutableLineStyle lineStyle];
//    greenLineStyle.lineColor = [CPTColor blackColor];
//    CPTPlotSymbol *greenPlotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
//    greenPlotSymbol.fill          = [CPTFill fillWithColor:[CPTColor blueColor]];
//    greenPlotSymbol.lineStyle     = greenLineStyle;
//    greenPlotSymbol.size          = CGSizeMake(1.0, 1.0);
//    dataSourceLinePlot.plotSymbol = greenPlotSymbol;
    
    // Put an area gradient under the plot above
//    CPTColor *areaColor       = [CPTColor colorWithComponentRed:0.3 green:1.0 blue:0.3 alpha:0.8];
//    CPTGradient *areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
//    areaGradient.angle               = -90.0f;
//    areaGradientFill                 = [CPTFill fillWithGradient:areaGradient];
//    dataSourceLinePlot.areaFill      = areaGradientFill;
//    dataSourceLinePlot.areaBaseValue = CPTDecimalFromString(@"1.75");
    
//    // Animate in the new plot, as an example
//    dataSourceLinePlot.opacity = 0.0f;
//    [graph addPlot:dataSourceLinePlot];
//    
//    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    fadeInAnimation.duration            = 2.0f;
//    fadeInAnimation.removedOnCompletion = NO;
//    fadeInAnimation.fillMode            = kCAFillModeForwards;
//    fadeInAnimation.toValue             = [NSNumber numberWithFloat:1.0];
//    [dataSourceLinePlot addAnimation:fadeInAnimation forKey:@"animateOpacity"];    

    // End Green plot
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(addDataPoint) userInfo:nil repeats:YES];
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [dataForPlot count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
    NSNumber *num = [[dataForPlot objectAtIndex:index] valueForKey:key];
    
    // Green plot gets shifted above the blue
//    if ( [(NSString *)plot.identifier isEqualToString:@"Green Plot"] ) {
//        if ( fieldEnum == CPTScatterPlotFieldY ) {
//            num = [NSNumber numberWithDouble:[num doubleValue] + 1.0];
//        }
//    }
//    
//    if (fieldEnum == CPTScatterPlotFieldY) num = [NSNumber numberWithDouble:[num doubleValue]
    return num;
}

#pragma mark -
#pragma mark Axis Delegate Methods

-(BOOL)axis:(CPTAxis *)axis shouldUpdateAxisLabelsAtLocations:(NSSet *)locations
{
    static CPTTextStyle *positiveStyle = nil;
    static CPTTextStyle *negativeStyle = nil;
    
    NSNumberFormatter *formatter = axis.labelFormatter;
    CGFloat labelOffset          = axis.labelOffset;
    NSDecimalNumber *zero        = [NSDecimalNumber zero];
    
    NSMutableSet *newLabels = [NSMutableSet set];
    
    for ( NSDecimalNumber *tickLocation in locations ) {
        CPTTextStyle *theLabelTextStyle;
        
        if ( [tickLocation isGreaterThanOrEqualTo:zero] ) {
            if ( !positiveStyle ) {
                CPTMutableTextStyle *newStyle = [axis.labelTextStyle mutableCopy];
                newStyle.color = [CPTColor greenColor];
                positiveStyle  = newStyle;
            }
            theLabelTextStyle = positiveStyle;
        }
        else {
            if ( !negativeStyle ) {
                CPTMutableTextStyle *newStyle = [axis.labelTextStyle mutableCopy];
                newStyle.color = [CPTColor redColor];
                negativeStyle  = newStyle;
            }
            theLabelTextStyle = negativeStyle;
        }
        
        NSString *labelString       = [formatter stringForObjectValue:tickLocation];
        CPTTextLayer *newLabelLayer = [[CPTTextLayer alloc] initWithText:labelString style:theLabelTextStyle];
        
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithContentLayer:newLabelLayer];
        newLabel.tickLocation = tickLocation.decimalValue;
        newLabel.offset       = labelOffset;
        
        [newLabels addObject:newLabel];
    }
    
    axis.axisLabels = newLabels;
    
    return NO;
}

- (IBAction)handleTap:(UITapGestureRecognizer *)sender {
    NSLog(@"handling tap");

//    [self addDataPoint];
    // select the data point
}

-(void)addDataPoint {
    id x = [[dataForPlot lastObject] objectForKey:@"x"];
    NSNumber *nextX = [NSNumber numberWithDouble:[x doubleValue] + 0.5];
    id y = [[dataForPlot lastObject] objectForKey:@"y"];
    NSNumber *nextY = [NSNumber numberWithDouble:[y doubleValue] + rand()/(float)RAND_MAX - 0.5];
    
    [dataForPlot addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:nextX, @"x", nextY, @"y", nil]];

    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;        

    // adjust y axis if we go above max value
    if ([nextY doubleValue] > plotSpace.yRange.maxLimitDouble) {
        plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:plotSpace.yRange.minLimit length:CPTDecimalFromDouble([nextY doubleValue] - plotSpace.yRange.minLimitDouble + 1)];        
    }
    
    // adjust y axis if we go below the min value
    if ([nextY doubleValue] < plotSpace.yRange.minLimitDouble) {
        plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:(CPTDecimalFromDouble([nextY doubleValue] - 1)) length:CPTDecimalFromDouble(plotSpace.yRange.lengthDouble + 1)];
    }
    
    // if we're not looking at historical data, bump the graph right.
    if ( [x doubleValue] < plotSpace.xRange.maxLimitDouble && [nextX doubleValue] + 1 > plotSpace.xRange.maxLimitDouble) {
        double newLocation = plotSpace.xRange.locationDouble + 1;
        double newLength = plotSpace.xRange.lengthDouble + 1;

        CPTPlotRange *newRange = [CPTPlotRange plotRangeWithLocation:(CPTDecimalFromDouble(newLocation)) length:(CPTDecimalFromDouble(newLength))];
        plotSpace.xRange = newRange;
        
        // move the y axis too 
        CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;        
        axisSet.yAxis.orthogonalCoordinateDecimal = newRange.location;
    }
    
    [graph reloadData];
}

@end
