//
//  SanoSubstanceViewController.h
//  Sano
//
//  Created by Raj Gokal on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Substance.h"
#import "MyManager.h"
#import "CorePlot-CocoaTouch.h"

@interface SanoSubstanceViewController : UIViewController<CPTPlotDataSource, CPTAxisDelegate, CPTPlotSpaceDelegate, CPTPlotDelegate>

{
    CPTXYGraph *graph;
    
    NSMutableArray *dataForPlot;
}

- (IBAction)handleTap:(UITapGestureRecognizer *)sender;

@property (nonatomic, strong) NSMutableArray *dataForPlot;
@property (nonatomic, weak) Substance *currentSubstance;

@end