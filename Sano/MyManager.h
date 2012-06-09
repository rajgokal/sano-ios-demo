//
//  MyManager.h
//  Sano
//
//  Created by Raj Gokal on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <foundation/Foundation.h>
#import "Metric.h"


@interface MyManager : NSObject {
    NSString *someProperty;
    NSMutableArray *substances;
    NSMutableArray *alerts;
    NSMutableArray *metrics;    
    int glucose;
    int calcium;
    int sodium;
    int potassium;
    int co2;
    int chloride;
    int bun;
    int creatinine;
}

@property (nonatomic, retain) NSString *someProperty;
@property (nonatomic, retain) NSMutableArray *substances;
@property (nonatomic, strong) NSMutableArray *alerts;
@property (nonatomic, strong) NSMutableArray *metrics;
@property (nonatomic, assign) int glucose;
@property (nonatomic, assign) int calcium;
@property (nonatomic, assign) int sodium;
@property (nonatomic, assign) int potassium;
@property (nonatomic, assign) int co2;
@property (nonatomic, assign) int chloride;
@property (nonatomic, assign) int bun;
@property (nonatomic, assign) int creatinine;

+ (id)sharedManager;

@end
