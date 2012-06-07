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

@interface SanoSubstanceViewController : UIViewController <CPTPlotDataSource>

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;

- (IBAction)handleTap:(UITapGestureRecognizer *) recognizer;

@property (nonatomic, strong) Substance *currentSubstance;

@property (nonatomic, weak) CPTXYGraph *graph;

@property (nonatomic, weak) NSMutableArray * dataForPlot;

@end