//
//  MyManager.m
//  Sano
//
//  Created by Raj Gokal on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyManager.h"
#import "Substance.h"

@implementation MyManager

@synthesize someProperty;
@synthesize glucose;
@synthesize calcium;
@synthesize sodium;
@synthesize potassium;
@synthesize co2;
@synthesize chloride;
@synthesize bun;
@synthesize creatinine;
@synthesize substances;
@synthesize alerts;
@synthesize metrics;

#pragma mark Singleton Methods

//Get the shared instance and create it if necessary
static MyManager *sharedManager = nil;

+ (id)sharedManager {
    @synchronized(self) {
        if (sharedManager == nil)
            sharedManager = [[self alloc] init];
    }
    return sharedManager;
}
- (id)init {
    self = [super init];
    if (!self) return nil;
    someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
    substances = [[NSMutableArray alloc] initWithCapacity:8];
    
    Substance *sub = [[Substance alloc]init];
    [sub setName:@"Glucose"];
    [sub setUnit:@"mg/dL"];
    [sub setNotes:@"Glucose concentration data"];
    [sub setMin:60];
    [sub setMax:99];
    [sub setInput:(sub.min+sub.max)/2];
    [sub setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@. If you've eaten recently, this may be normal. Otherwise, your doctor may need to increase your insulin dosage.",sub.name,sub.max,sub.unit]];
    [sub setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Eating a fruit or drinking juice can restore blood glucose levels.",sub.name,sub.min,sub.unit]];
    
    [self.substances addObject:sub];
    
    sub = [[Substance alloc]init];
    [sub setName:@"Calcium"];
    [sub setUnit:@"mg/dL"];
    [sub setNotes:@"Calcium concentration data"];
    [sub setMin:8.7];
    [sub setMax:10.7];
    [sub setInput:(sub.min+sub.max)/2];
    [sub setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to decrease your Acetazolamide dosage.",sub.name,sub.max,sub.unit]];
    [sub setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@.  Dairy is rich in calcium and can promote bone health.",sub.name,sub.min,sub.unit]];
    
    [self.substances addObject:sub];
    
    sub = [[Substance alloc]init];
    [sub setName:@"Sodium"];
    [sub setUnit:@"mmol/L"];
    [sub setNotes:@"Sodium concentration data"];
    [sub setMin:137];
    [sub setMax:147];
    [sub setInput:(sub.min+sub.max)/2];
    [sub setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to decrease your anabolic steroid dosage.",sub.name,sub.max,sub.unit]];
    [sub setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@.  Your doctor may need to decrease your Carbamazepine dosage.",sub.name,sub.min,sub.unit]];
    
    [self.substances addObject:sub];
    
    sub = [[Substance alloc]init];
    [sub setName:@"Potassium"];
    [sub setUnit:@"mmol/L"];
    [sub setNotes:@"Potassium concentration data"];
    [sub setMin:3.4];
    [sub setMax:5.3];
    [sub setInput:(sub.min+sub.max)/2];
    [sub setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to increase your Acetazolamide dosage.",sub.name,sub.max,sub.unit]];
    [sub setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@.  Your doctor may need to increase your ACE inhibitor dosage.",sub.name,sub.min,sub.unit]];
    
    [self.substances addObject:sub];
    
    sub = [[Substance alloc]init];
    [sub setName:@"CO2"];
    [sub setUnit:@"mmol/L"];
    [sub setNotes:@"CO2 concentration data"];
    [sub setMin:22];
    [sub setMax:29];
    [sub setInput:(sub.min+sub.max)/2];
    [sub setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@. You may be retaining fluid, which causes an imbalance in your body's electrolytes.",sub.name,sub.max,sub.unit]];
    [sub setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. You may be dehydrated, which causes an imbalance in your body's electrolytes.",sub.name,sub.min,sub.unit]];
    
    [self.substances addObject:sub];
    
    sub = [[Substance alloc]init];
    [sub setName:@"Chloride"];
    [sub setUnit:@"mmol/L"];
    [sub setNotes:@"Chloride concentration data"];
    [sub setMin:99];
    [sub setMax:108];
    [sub setInput:(sub.min+sub.max)/2];
    [sub setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to decrease your Acetazolamide dosage.",sub.name,sub.max,sub.unit]];
    [sub setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@.  Your doctor may need to decrease your Aldosterone dosage.",sub.name,sub.min,sub.unit]];
    
    [self.substances addObject:sub];
    
    sub = [[Substance alloc]init];
    [sub setName:@"Blood Urea Nitrogen"];
    [sub setUnit:@"mg/dL"];
    [sub setNotes:@"BUN concentration data"];
    [sub setMin:8];
    [sub setMax:21];
    [sub setInput:(sub.min+sub.max)/2];
    [sub setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to decrease your Allopurinol dosage.",sub.name,sub.max,sub.unit]];
    [sub setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@.  Your doctor may need to decrease your Chloramphenicol dosage.",sub.name,sub.min,sub.unit]];
    
    [self.substances addObject:sub];
    
    sub = [[Substance alloc]init];
    [sub setName:@"Creatinine"];
    [sub setUnit:@"mg/dL"];
    [sub setNotes:@"Creatinine concentration data"];
    [sub setMin:0.75];
    [sub setMax:1.2];
    [sub setInput:(sub.min+sub.max)/2];
    [sub setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",sub.name,sub.max]];
    [sub setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",sub.name,sub.min]];
    
    [self.substances addObject:sub];
    
    metrics = [[NSMutableArray alloc] initWithCapacity:8];
    
    Metric *met = [[Metric alloc]init];
    [met setName:@"Energy"];
    [met setScore:0.5];
    [met setYesterday:(met.score*1.05)];
    
    [self.metrics addObject:met];
    
    met = [[Metric alloc]init];
    [met setName:@"Alertness"];
    [met setScore:0.6];
    [met setYesterday:(met.score*1.05)];    
    [self.metrics addObject:met];
    
    met = [[Metric alloc]init];
    [met setName:@"Nutrition"];
    [met setScore:0.7];
    [met setYesterday:(met.score*1.05)];
    
    [self.metrics addObject:met];
    
    met = [[Metric alloc]init];
    [met setName:@"Fitness"];
    [met setScore:0.8];
    [met setYesterday:(met.score*1.05)];
    
    [self.metrics addObject:met];
    
    met = [[Metric alloc]init];
    [met setName:@"Longevity"];
    [met setScore:0.9];
    [met setYesterday:(met.score*1.05)];
    
    [self.metrics addObject:met];
    
    alerts = [[NSMutableArray alloc] initWithCapacity:1];
    for (id current in self.substances) {
        if ([current input] > [current max] | [current input] < [current min])
            [current createAlert];
    }
    
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
