//
//  SanoSubstanceViewController.m
//  Sano
//
//  Created by Raj Gokal on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SanoSubstanceViewController.h"

static NSString *const MAIN_PLOT      = @"Scatter Plot";
static NSString *const SELECTION_PLOT = @"Selection Plot";

@interface SanoSubstanceViewController()

-(void) addDataPoint;
-(void) setupGraph;
-(void) setupAxes;
-(void) initializeData;
-(void) setupScatterPlots;
-(double) extrema:(NSString *)extrema ForAxis:(NSString *)axis;
-(double) minXValue;
-(double) minYValue;
-(double) maxXValue;
-(double) maxYValue;
-(double) midXValue;
-(double) midYValue;

@property (nonatomic, readwrite) NSUInteger selectedIndex;

@end

@implementation SanoSubstanceViewController

@synthesize dataForPlot;
@synthesize currentSubstance;
@synthesize selectedIndex;

-(void)setSelectedIndex:(NSUInteger)newIndex
{
    if ( selectedIndex != newIndex ) {
        selectedIndex = newIndex;
        [[graph plotWithIdentifier:SELECTION_PLOT] reloadData];
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(void)scatterPlot:(CPTScatterPlot *)plot plotSymbolWasSelectedAtRecordIndex:(NSUInteger)index
{
    if ( symbolTextAnnotation ) {
        [graph.plotAreaFrame.plotArea removeAnnotation:symbolTextAnnotation];
        symbolTextAnnotation = nil;
    }
    
    // Setup a style for the annotation
    CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
    hitAnnotationTextStyle.color    = [CPTColor whiteColor];
    hitAnnotationTextStyle.fontSize = 16.0f;
    hitAnnotationTextStyle.fontName = @"Helvetica-Bold";
    
    // Determine point of symbol in plot coordinates
    NSNumber *x          = [[dataForPlot objectAtIndex:index] valueForKey:@"x"];
    NSNumber *y          = [[dataForPlot objectAtIndex:index] valueForKey:@"y"];
    NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
    
    // Add annotation
    // First make a string for the y value
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
    NSString *yString = [formatter stringFromNumber:y];
    
    // Now add the annotation to the plot area
    CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:yString style:hitAnnotationTextStyle];
    symbolTextAnnotation              = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:graph.defaultPlotSpace anchorPlotPoint:anchorPoint];
    symbolTextAnnotation.contentLayer = textLayer;
    symbolTextAnnotation.displacement = CGPointMake(0.0f, 20.0f);
    [graph.plotAreaFrame.plotArea addAnnotation:symbolTextAnnotation];

}

-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDownEvent:(id)event atPoint:(CGPoint)point
{
    if ( symbolTextAnnotation ) {
        [graph.plotAreaFrame.plotArea removeAnnotation:symbolTextAnnotation];
        symbolTextAnnotation = nil;
    }
    return YES;
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

-(double) midYValue {
    return ([self maxYValue] - [self minYValue])/2;
}

-(double) midXValue {
    return ([self maxXValue] - [self minXValue])/2;
}

-(void) initializeData {
    NSMutableArray *contentArray = [NSMutableArray arrayWithCapacity:100];
    NSUInteger i;
    
    NSNumber *mid = [NSNumber numberWithDouble:((currentSubstance.max - currentSubstance.min)/2)];
    
    [contentArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0], @"x", mid, @"y", nil]];
    self.dataForPlot = contentArray;
    
    for ( i = 0; i < 20; i++ ) {
        [self addDataPoint];        
    }
}

-(void) setupGraph {
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
    
    double xLength = [self maxXValue] - [self minXValue];
    double yLength = [self maxYValue] - [self minYValue];
    
    // Setup plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    plotSpace.xRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat((float) [self minXValue] - 0.5) length:CPTDecimalFromFloat((float) xLength + 2)];
    plotSpace.yRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat((float) [self minYValue] - 0.5) length:CPTDecimalFromFloat((float) yLength + 1)];
    plotSpace.delegate = self;    
}

-(void)setupAxes {
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    x.orthogonalCoordinateDecimal = CPTDecimalFromDouble([self minYValue] - 0.3);
    x.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    x.minorTicksPerInterval       = 2;
    x.preferredNumberOfMajorTicks = 6;
    
    CPTXYAxis *y = axisSet.yAxis;
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    y.labelOffset                 = -35;
    y.delegate             = self;
    y.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    y.preferredNumberOfMajorTicks = 4;
    y.minorTicksPerInterval       = 5;
    
    // Create the acceptable threshold guide
    CPTFill *fill = [CPTFill fillWithColor:[CPTColor grayColor]];
    CPTPlotRange *fillRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble([self midYValue] - 0.2) length:CPTDecimalFromDouble([self midYValue] + 0.2)];
    
    [y addBackgroundLimitBand:[CPTLimitBand limitBandWithRange:fillRange fill:fill]];    
}

-(void)setupScatterPlots {
    CPTScatterPlot *dataSourceLinePlot  = [[CPTScatterPlot alloc] init];
    
    dataSourceLinePlot.identifier = MAIN_PLOT;
    
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit        = 1.0f;
    lineStyle.lineWidth         = 3.0f;
    lineStyle.lineColor         = [CPTColor blueColor];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    
    dataSourceLinePlot.dataSource    = self;
    dataSourceLinePlot.interpolation = CPTScatterPlotInterpolationCurved;
    dataSourceLinePlot.delegate = self;
    dataSourceLinePlot.plotSymbolMarginForHitDetection = 5.0;
    
    [graph addPlot:dataSourceLinePlot];

    // Add plot symbols
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor blackColor];
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor blueColor]];
    plotSymbol.lineStyle     = symbolLineStyle;
    plotSymbol.size          = CGSizeMake(1.0, 1.0);
    dataSourceLinePlot.plotSymbol = plotSymbol;

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self setupGraph];
    [self setupAxes];
    [self setupScatterPlots];
    
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
    NSNumber *num = nil;
    
    if ( [(NSString *)plot.identifier isEqualToString:MAIN_PLOT] ) {    
        NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
        num = [[dataForPlot objectAtIndex:index] valueForKey:key];
    }
    else if ( [(NSString *)plot.identifier isEqualToString:SELECTION_PLOT] ) {    
        CPTXYPlotSpace *thePlotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
        
        switch ( fieldEnum ) {
            case CPTScatterPlotFieldX:
                switch ( index ) {
                    case 0:
                        num = [NSDecimalNumber decimalNumberWithDecimal:thePlotSpace.globalXRange.minLimit];
                        break;
                        
                    case 1:
                        num = [NSDecimalNumber decimalNumberWithDecimal:thePlotSpace.globalXRange.maxLimit];
                        break;
                        
                    case 2:
                    case 3:
                    case 4:
                        num = [[self.dataForPlot objectAtIndex:self.selectedIndex] valueForKey:@"x"];
                        break;
                        
                    default:
                        break;
                }
                break;
                
            case CPTScatterPlotFieldY:
                switch ( index ) {
                    case 0:
                    case 1:
                    case 2:
                        num = [[self.dataForPlot objectAtIndex:self.selectedIndex] valueForKey:@"y"];
                        break;
                        
                    case 3:
                        num = [NSDecimalNumber decimalNumberWithDecimal:thePlotSpace.globalYRange.maxLimit];
                        break;
                        
                    case 4:
                        num = [NSDecimalNumber decimalNumberWithDecimal:thePlotSpace.globalYRange.minLimit];
                        break;
                        
                    default:
                        break;
                }
                break;
                
            default:
                break;
        }
    }
    return num;
}

-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    return nil;
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
