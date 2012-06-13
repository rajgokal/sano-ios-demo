//
//  MyManager.h
//  Sano
//
//  Created by Raj Gokal on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <foundation/Foundation.h>
#import "Metric.h"
#import "Substance.h"
#import "Metric.h"


@interface MyManager : NSObject {
    NSString *someProperty;
    NSMutableArray *substances;
    NSMutableArray *alerts;
    NSMutableArray *metrics;
}

@property (nonatomic, strong) NSString *someProperty;
@property (nonatomic, strong) NSMutableArray *substances;
@property (nonatomic, strong) NSMutableArray *alerts;
@property (nonatomic, strong) NSMutableArray *metrics;
@property (nonatomic, assign) Substance *glucose;
@property (nonatomic, assign) Substance *calcium;
@property (nonatomic, assign) Substance *sodium;
@property (nonatomic, assign) Substance *potassium;
@property (nonatomic, assign) Substance *CO2;
@property (nonatomic, assign) Substance *chloride;
@property (nonatomic, assign) Substance *bun;
@property (nonatomic, assign) Substance *creatinine;
@property (nonatomic, assign) Substance *sleep;
@property (nonatomic, assign) Substance *VO2;
@property (nonatomic, assign) Substance *lactate;
@property (nonatomic, assign) Substance *B1;
@property (nonatomic, assign) Substance *B5;
@property (nonatomic, assign) Substance *B6;
@property (nonatomic, assign) Substance *D;
@property (nonatomic, assign) Substance *bloodPressure;
@property (nonatomic, assign) Substance *weight;
@property (nonatomic, strong) Metric *energy;
@property (nonatomic, assign) Metric *alertness;
@property (nonatomic, assign) Metric *fitness;
@property (nonatomic, assign) Metric *nutrition;
@property (nonatomic, assign) Metric *longevity;
@property (nonatomic, assign) Metric *muscleStrength;
@property (nonatomic, assign) Metric *hydration;
@property (nonatomic, assign) Metric *stamina;

+ (id)sharedManager;

@end
