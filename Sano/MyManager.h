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
#import "UserType.h"

@interface MyManager : NSObject {
    NSMutableArray *substances;
    NSMutableArray *alerts;
    NSMutableArray *metrics;
}

@property (nonatomic, strong) NSMutableArray *substances;
@property (nonatomic, strong) NSMutableArray *alerts;
@property (nonatomic, strong) NSMutableArray *metrics;
@property (nonatomic, strong) NSMutableArray *userTypes;
@property (nonatomic, strong) Substance *glucose;
@property (nonatomic, strong) Substance *calcium;
@property (nonatomic, strong) Substance *sodium;
@property (nonatomic, strong) Substance *potassium;
@property (nonatomic, strong) Substance *CO2;
@property (nonatomic, strong) Substance *chloride;
@property (nonatomic, strong) Substance *bun;
@property (nonatomic, strong) Substance *creatinine;
@property (nonatomic, strong) Substance *sleep;
@property (nonatomic, strong) Substance *VO2;
@property (nonatomic, strong) Substance *lactate;
@property (nonatomic, strong) Substance *B1;
@property (nonatomic, strong) Substance *B5;
@property (nonatomic, strong) Substance *B6;
@property (nonatomic, strong) Substance *D;
@property (nonatomic, strong) Substance *bmi;
@property (nonatomic, strong) Substance *bloodPressure;
@property (nonatomic, strong) Substance *weight;
@property (nonatomic, strong) Substance *iron;
@property (nonatomic, strong) Substance *zinc;
@property (nonatomic, strong) Substance *basalTemp;
@property (nonatomic, strong) Metric *fertilityLevel;
@property (nonatomic, strong) Metric *energy;
@property (nonatomic, strong) Metric *alertness;
@property (nonatomic, strong) Metric *fitness;
@property (nonatomic, strong) Metric *nutrition;
@property (nonatomic, strong) Metric *longevity;
@property (nonatomic, strong) Metric *muscleStrength;
@property (nonatomic, strong) Metric *hydration;
@property (nonatomic, strong) Metric *stamina;
@property (nonatomic, strong) Metric *kidneyHealth;
@property (nonatomic, strong) Metric * bunCreatinine;
@property (nonatomic, strong) Metric * sleepMetric;
@property (nonatomic, strong) Metric * hormoneBalance;
@property (nonatomic, strong) UserType *chronicKidney;
@property (nonatomic, strong) UserType *cyclist;
@property (nonatomic, strong) UserType *fertUser;

+ (id)sharedManager;

@end
