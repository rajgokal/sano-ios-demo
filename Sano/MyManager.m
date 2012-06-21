//
//  MyManager.m
//  Sano
//
//  Created by Raj Gokal on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyManager.h"
#import "Substance.h"
#import "UserType.h"

@implementation MyManager

//Various data being captured
@synthesize glucose;
@synthesize calcium;
@synthesize sodium;
@synthesize potassium;
@synthesize CO2;
@synthesize chloride;
@synthesize bun;
@synthesize creatinine;
@synthesize sleep;
@synthesize VO2;
@synthesize lactate;
@synthesize B1;
@synthesize B5;
@synthesize B6;
@synthesize D;
@synthesize bmi;
@synthesize bloodPressure;
@synthesize weight;
@synthesize zinc;
@synthesize iron;
@synthesize basalTemp;

//"Proprietary metrics" generated from various data
@synthesize energy;
@synthesize alertness;
@synthesize fitness;
@synthesize nutrition;
@synthesize longevity;
@synthesize muscleStrength;
@synthesize hydration;
@synthesize stamina;
@synthesize kidneyHealth;
@synthesize fertilityLevel;
@synthesize bunCreatinine;
@synthesize sleepMetric;
@synthesize hormoneBalance;

//Stores for different combinations of the data
@synthesize substances;
@synthesize alerts;
@synthesize metrics;
@synthesize userTypes;

// User Types
@synthesize chronicKidney = _chronicKidney;
@synthesize cyclist = _cyclist;
@synthesize fertUser = _fertUser;

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

    substances = [[NSMutableArray alloc] initWithCapacity:8];
    
    self.glucose = [[Substance alloc]init];
    
    [self.glucose setName:@"Glucose"];
    [self.glucose setUnit:@"mg/dL"];
    [self.glucose setNotes:@"Glucose concentration data"];
    [self.glucose setMin:60];
    [self.glucose setMax:99];
    self.glucose.absoluteMax = 180;
    self.glucose.absoluteMin = 50;
    [self.glucose setInput:(self.glucose.min+self.glucose.max)/2];
    [self.glucose setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@. If you've eaten recently, this may be normal. Otherwise, your doctor may need to increase your insulin dosage.",self.glucose.name,self.glucose.max,self.glucose.unit]];
    [self.glucose setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Eating a fruit or drinking juice can restore blood glucose levels.",self.glucose.name,self.glucose.min,self.glucose.unit]];
    
    [self.substances addObject:self.glucose];
    
    self.calcium = [[Substance alloc]init];
    [self.calcium setName:@"Calcium"];
    [self.calcium setUnit:@"mg/dL"];
    [self.calcium setNotes:@"Calcium concentration data"];
    [self.calcium setMin:8.7];
    [self.calcium setMax:10.7];
    self.calcium.absoluteMin = 8.0;
    self.calcium.absoluteMax = 10.7;
    [self.calcium setInput:(self.calcium.min+self.calcium.max)/2];
    [self.calcium setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to decrease your Acetazolamide dosage.",self.calcium.name,self.calcium.max,self.calcium.unit]];
    [self.calcium setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@.  Dairy is rich in calcium and can promote bone health.",self.calcium.name,self.calcium.min,self.calcium.unit]];
    
    [self.substances addObject:self.calcium];
    
    self.sodium = [[Substance alloc]init];
    [self.sodium setName:@"Sodium"];
    [self.sodium setUnit:@"mmol/L"];
    [self.sodium setNotes:@"Sodium concentration data"];
    [self.sodium setMin:135];
    [self.sodium setMax:145];
    self.sodium.absoluteMin = 135;
    self.sodium.absoluteMax = 145;
    [self.sodium setInput:(self.sodium.min+self.sodium.max)/2];
    [self.sodium setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to decrease your anabolic steroid dosage.",self.sodium.name,self.sodium.max,self.sodium.unit]];
    [self.sodium setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@.  Your doctor may need to decrease your Carbamazepine dosage.",self.sodium.name,self.sodium.min,self.sodium.unit]];
    
    [self.substances addObject:self.sodium];
    
    self.potassium = [[Substance alloc]init];
    [self.potassium setName:@"Potassium"];
    [self.potassium setUnit:@"mmol/L"];
    [self.potassium setNotes:@"Potassium concentration data"];
    [self.potassium setMin:3.7];
    [self.potassium setMax:5.7];
    self.potassium.absoluteMin = 2;
    self.potassium.absoluteMin = 7;
    [self.potassium setInput:(self.potassium.min+self.potassium.max)/2];
    [self.potassium setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to increase your Acetazolamide dosage.",self.potassium.name,self.potassium.max,self.potassium.unit]];
    [self.potassium setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@.  Your doctor may need to increase your ACE inhibitor dosage.",self.potassium.name,self.potassium.min,self.potassium.unit]];
    
    [self.substances addObject:self.potassium];
    
    self.CO2 = [[Substance alloc]init];
    [self.CO2 setName:@"CO2"];
    [self.CO2 setUnit:@"mmol/L"];
    [self.CO2 setNotes:@"CO2 concentration data"];
    [self.CO2 setMin:22];
    [self.CO2 setMax:29];
    self.CO2.absoluteMin = 16;
    self.CO2.absoluteMax = 36;
    [self.CO2 setInput:(self.CO2.min+self.CO2.max)/2];
    [self.CO2 setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@. You may be retaining fluid, which causes an imbalance in your body's electrolytes.",self.CO2.name,self.CO2.max,self.CO2.unit]];
    [self.CO2 setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. You may be dehydrated, which causes an imbalance in your body's electrolytes.",self.CO2.name,self.CO2.min,self.CO2.unit]];
    
    [self.substances addObject:self.CO2];
    
    self.chloride = [[Substance alloc]init];
    [self.chloride setName:@"Chloride"];
    [self.chloride setUnit:@"mmol/L"];
    [self.chloride setNotes:@"Chloride concentration data"];
    [self.chloride setMin:96];
    [self.chloride setMax:106];
    self.chloride.absoluteMin = 90;
    self.chloride.absoluteMax = 120;
    [self.chloride setInput:(self.chloride.min+self.chloride.max)/2];
    [self.chloride setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to decrease your Acetazolamide dosage.",self.chloride.name,self.chloride.max,self.chloride.unit]];
    [self.chloride setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@.  Your doctor may need to decrease your Aldosterone dosage.",self.chloride.name,self.chloride.min,self.chloride.unit]];
    
    [self.substances addObject:self.chloride];
    
    self.bun = [[Substance alloc]init];
    [self.bun setName:@"Blood Urea Nitrogen"];
    [self.bun setUnit:@"mg/dL"];
    [self.bun setNotes:@"BUN concentration data"];
    [self.bun setMin:8];
    [self.bun setMax:21];
    self.bun.absoluteMin = 5;
    self.bun.absoluteMax = 28;
    [self.bun setInput:(self.bun.min+self.bun.max)/2];
    [self.bun setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to decrease your Allopurinol dosage.",self.bun.name,self.bun.max,self.bun.unit]];
    [self.bun setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@.  Your doctor may need to decrease your Chloramphenicol dosage.",self.bun.name,self.bun.min,self.bun.unit]];
    
    [self.substances addObject:self.bun];
    
    self.creatinine = [[Substance alloc]init];
    [self.creatinine setName:@"Creatinine"];
    [self.creatinine setUnit:@"mg/dL"];
    [self.creatinine setNotes:@"Creatinine concentration data"];
    [self.creatinine setMin:0.75];
    [self.creatinine setMax:1.2];
    self.creatinine.absoluteMin = 0.4;
    self.creatinine.absoluteMax = 1.6;
    [self.creatinine setInput:(self.creatinine.min+self.creatinine.max)/2];
    [self.creatinine setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.creatinine.name,self.creatinine.max]];
    [self.creatinine setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.creatinine.name,self.creatinine.min]];

    [self.substances addObject:self.creatinine];
    
    self.sleep = [[Substance alloc]init];
    [self.sleep setName:@"Sleep"];
    [self.sleep setUnit:@"mg/dL"];
    [self.sleep setNotes:@"Sleep concentration data"];
    [self.sleep setMin:0.75];
    [self.sleep setMax:1.2];
    self.sleep.absoluteMin = 0.4;
    self.sleep.absoluteMax = 1.6;
    [self.sleep setInput:(self.sleep.min+self.sleep.max)/2];
    [self.sleep setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.sleep.name,self.sleep.max]];
    [self.sleep setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.sleep.name,self.sleep.min]];
    
    [self.substances addObject:self.sleep];
    
    self.VO2 = [[Substance alloc]init];
    [self.VO2 setName:@"VO2"];
    [self.VO2 setUnit:@"mg/dL"];
    [self.VO2 setNotes:@"VO2 concentration data"];
    [self.VO2 setMin:0.75];
    [self.VO2 setMax:1.2];
    self.VO2.absoluteMin = 0.4;
    self.VO2.absoluteMax = 1.6;
    [self.VO2 setInput:(self.VO2.min+self.VO2.max)/2];
    [self.VO2 setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.VO2.name,self.VO2.max]];
    [self.VO2 setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.VO2.name,self.VO2.min]];
    
    [self.substances addObject:self.VO2];
    
    
    self.lactate = [[Substance alloc]init];
    [self.lactate setName:@"Lactate"];
    [self.lactate setUnit:@"mg/dL"];
    [self.lactate setNotes:@"Lactate concentration data"];
    [self.lactate setMin:0.75];
    [self.lactate setMax:1.2];
    self.lactate.absoluteMin = 0.4;
    self.lactate.absoluteMax = 1.6;
    [self.lactate setInput:(self.lactate.min+self.lactate.max)/2];
    [self.lactate setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.lactate.name,self.lactate.max]];
    [self.lactate setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.lactate.name,self.lactate.min]];
    
    [self.substances addObject:self.lactate];
    
    self.B1 = [[Substance alloc]init];
    [self.B1 setName:@"Vitamin B1"];
    [self.B1 setUnit:@"mg/dL"];
    [self.B1 setNotes:@"Vitamin B1 concentration data"];
    [self.B1 setMin:0.75];
    [self.B1 setMax:1.2];
    self.B1.absoluteMin = 0.4;
    self.B1.absoluteMax = 1.6;
    [self.B1 setInput:(self.B1.min+self.B1.max)/2];
    [self.B1 setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.B1.name,self.B1.max]];
    [self.B1 setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.B1.name,self.B1.min]];
    
    [self.substances addObject:self.B1];
    
    self.B5 = [[Substance alloc]init];
    [self.B5 setName:@"Vitamin B5"];
    [self.B5 setUnit:@"mg/dL"];
    [self.B5 setNotes:@"Vitamin B5 concentration data"];
    [self.B5 setMin:0.75];
    [self.B5 setMax:1.2];
    self.B5.absoluteMin = 0.4;
    self.B5.absoluteMax = 1.6;
    [self.B5 setInput:(self.B5.min+self.B5.max)/2];
    [self.B5 setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.B5.name,self.B5.max]];
    [self.B5 setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.B5.name,self.B5.min]];
    
    [self.substances addObject:self.B5];
    
    self.B6 = [[Substance alloc]init];
    [self.B6 setName:@"Vitamin B6"];
    [self.B6 setUnit:@"mg/dL"];
    [self.B6 setNotes:@"Vitamin B6 concentration data"];
    [self.B6 setMin:0.75];
    [self.B6 setMax:1.2];
    self.B6.absoluteMin = 0.4;
    self.B6.absoluteMax = 1.6;
    [self.B6 setInput:(self.B6.min+self.B6.max)/2];
    [self.B6 setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.B6.name,self.B6.max]];
    [self.B6 setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.B6.name,self.B6.min]];
    
    [self.substances addObject:self.B6];
    
    self.D = [[Substance alloc]init];
    [self.D setName:@"Vitamin D"];
    [self.D setUnit:@"mg/dL"];
    [self.D setNotes:@"Vitamin D concentration data"];
    [self.D setMin:0.75];
    [self.D setMax:1.2];
    self.D.absoluteMin = 0.4;
    self.D.absoluteMax = 1.6;
    [self.D setInput:(self.D.min+self.D.max)/2];
    [self.D setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.D.name,self.D.max]];
    [self.D setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.D.name,self.D.min]];
    
    [self.substances addObject:self.D];
    
    self.bloodPressure = [[Substance alloc]init];
    [self.bloodPressure setName:@"Blood Pressure"];
    [self.bloodPressure setUnit:@"mg/dL"];
    [self.bloodPressure setNotes:@"Blood Pressure data"];
    [self.bloodPressure setMin:0.75];
    [self.bloodPressure setMax:1.2];
    self.bloodPressure.absoluteMin = 0.4;
    self.bloodPressure.absoluteMax = 1.6;
    [self.bloodPressure setInput:(self.bloodPressure.min+self.bloodPressure.max)/2];
    [self.bloodPressure setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.bloodPressure.name,self.bloodPressure.max]];
    [self.bloodPressure setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.bloodPressure.name,self.bloodPressure.min]];
    
    [self.substances addObject:self.bloodPressure];
    
    self.bmi = [[Substance alloc]init];
    [self.bmi setName:@"BMI"];
    [self.bmi setUnit:@"mg/dL"];
    [self.bmi setNotes:@"BMI data"];
    [self.bmi setMin:0.75];
    [self.bmi setMax:1.2];
    self.bmi.absoluteMin = 0.4;
    self.bmi.absoluteMax = 1.6;
    [self.bmi setInput:(self.bmi.min+self.bmi.max)/2];
    [self.bmi setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.bmi.name,self.bmi.max]];
    [self.bmi setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.bmi.name,self.bmi.min]];
    
    [self.substances addObject:self.bmi];
    
    self.zinc = [[Substance alloc]init];
    [self.zinc setName:@"Zinc"];
    [self.zinc setUnit:@"mg/dL"];
    [self.zinc setNotes:@"BMI data"];
    [self.zinc setMin:0.75];
    [self.zinc setMax:1.2];
    self.zinc.absoluteMin = 0.4;
    self.zinc.absoluteMax = 1.6;
    [self.zinc setInput:(self.zinc.min+self.zinc.max)/2];
    [self.zinc setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.zinc.name,self.zinc.max]];
    [self.zinc setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.zinc.name,self.zinc.min]];
    
    [self.substances addObject:self.zinc];
    
    self.iron = [[Substance alloc]init];
    [self.iron setName:@"Iron"];
    [self.iron setUnit:@"mg/dL"];
    [self.iron setNotes:@"BMI data"];
    [self.iron setMin:0.75];
    [self.iron setMax:1.2];
    self.iron.absoluteMin = 0.4;
    self.iron.absoluteMax = 1.6;
    [self.iron setInput:(self.iron.min+self.iron.max)/2];
    [self.iron setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.iron.name,self.iron.max]];
    [self.iron setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.iron.name,self.iron.min]];
    
    [self.substances addObject:self.iron];
    
    self.basalTemp = [[Substance alloc]init];
    [self.basalTemp setName:@"Basal Temperature"];
    [self.basalTemp setUnit:@"degrees"];
    [self.basalTemp setNotes:@"Temperature data"];
    [self.basalTemp setMin:0.75];
    [self.basalTemp setMax:1.2];
    self.basalTemp.absoluteMin = 0.4;
    self.basalTemp.absoluteMax = 1.6;
    [self.basalTemp setInput:(self.basalTemp.min+self.basalTemp.max)/2];
    [self.basalTemp setBadSuggestion:[NSString stringWithFormat:@"Your %@ is above your target maximum, %i %@.  Your doctor may need to adjust your Aminoglycosides dosage.",self.iron.name,self.iron.max]];
    [self.basalTemp setGoodSuggestion:[NSString stringWithFormat:@"Your %@ is below your target minimum, %i %@. Your doctor may need to adjust your Aminoglycosides dosage.",self.basalTemp.name,self.basalTemp.min]];
    
    [self.substances addObject:self.iron];

    metrics = [[NSMutableArray alloc] initWithCapacity:20];
    
    self.energy = [[Metric alloc] init];
    [self.energy setName:@"Energy"];
    [self.energy setScore:0.5];
    [self.energy setYesterday:(self.energy.score*1.05)];
    
    [self.metrics addObject:self.energy];
    
    self.alertness = [[Metric alloc]init];
    [self.alertness setName:@"Alertness"];
    [self.alertness setScore:0.6];
    [self.alertness setYesterday:(self.alertness.score*1.05)];    
    [self.metrics addObject:self.alertness];
    
    self.nutrition = [[Metric alloc]init];
    [self.nutrition setName:@"Nutrition"];
    [self.nutrition setScore:0.7];
    [self.nutrition setYesterday:(self.nutrition.score*1.05)];
    
    [self.metrics addObject:self.nutrition];
    
    self.fitness = [[Metric alloc]init];
    [self.fitness setName:@"Fitness"];
    [self.fitness setScore:0.8];
    [self.fitness setYesterday:(self.fitness.score*1.05)];
    
    [self.metrics addObject:self.fitness];
    
    self.fitness = [[Metric alloc]init];
    [self.fitness setName:@"Longevity"];
    [self.fitness setScore:0.9];
    [self.fitness setYesterday:(self.fitness.score*1.05)];
    
    [self.metrics addObject:self.fitness];
    
    self.kidneyHealth = [[Metric alloc]init];
    self.kidneyHealth.name = @"Kidney Health";
    self.kidneyHealth.score = 0.8;
    self.kidneyHealth.yesterday = self.kidneyHealth.score*1.05;
    
    [self.metrics addObject:self.kidneyHealth];
    
    self.fertilityLevel = [[Metric alloc]init];
    self.fertilityLevel.name = @"Fertility Level";
    self.fertilityLevel.score = 0.8;
    self.fertilityLevel.yesterday = self.fertilityLevel.score*1.05;
    
    [self.metrics addObject:self.fertilityLevel];
    
    self.stamina = [[Metric alloc] init];
    self.stamina.name = @"Stamina";
    self.stamina.score = 0.76;
    self.stamina.yesterday = self.stamina.score*0.95;
    
    [self.metrics addObject:self.stamina];
    
    self.hydration = [[Metric alloc] init];
    self.hydration.name = @"Hydration";
    self.hydration.score = 0.55;
    self.hydration.yesterday = self.hydration.score*1.05;
    
    [self.metrics addObject:self.hydration];
    
    self.muscleStrength = [[Metric alloc] init];
    self.muscleStrength.name = @"Muscle Strength";
    self.muscleStrength.score = 0.89;
    self.muscleStrength.yesterday = self.muscleStrength.score*0.95;
    
    [self.metrics addObject:self.muscleStrength];
    
    self.bunCreatinine = [[Metric alloc] init];
    self.bunCreatinine.name = @"BUN / Creatinine";
    self.bunCreatinine.score = 0.76;
    self.bunCreatinine.yesterday = self.bunCreatinine.score*0.8;
    
    [self.metrics addObject:self.bunCreatinine];
    
    self.sleepMetric = [[Metric alloc] init];
    self.sleepMetric.name = @"Sleep Score";
    self.sleepMetric.score = 0.9;
    self.sleepMetric.yesterday = self.sleepMetric.score*0.9;
    
    [self.metrics addObject:self.sleepMetric];
    
    self.hormoneBalance = [[Metric alloc] init];
    self.hormoneBalance.name = @"Hormone Balance";
    self.hormoneBalance.score = 0.9;
    self.hormoneBalance.yesterday = self.hormoneBalance.score*1.06;
    
    [self.metrics addObject:self.hormoneBalance];
    
    alerts = [[NSMutableArray alloc] initWithCapacity:1];
    for (id current in self.substances) {
        if ([current input] > [current max] | [current input] < [current min])
            [current createAlert];
    }
    
    userTypes = [[NSMutableArray alloc] initWithCapacity:8];
    
    self.chronicKidney = [[UserType alloc] init];
    self.chronicKidney.name = @"Chronic Kidney Disease";
    self.chronicKidney.metrics = [NSArray arrayWithObjects:self.energy, self.kidneyHealth, self.sleepMetric, self.bunCreatinine, nil];
    
    [self.userTypes addObject:self.chronicKidney];
    
    self.cyclist = [[UserType alloc] init];
    self.cyclist.name = @"Cyclist";
    self.cyclist.metrics = [NSArray arrayWithObjects:self.energy, self.stamina, self.hydration, self.muscleStrength, nil];
    
    [self.userTypes addObject:self.cyclist];
    
    self.fertUser = [[UserType alloc] init];
    self.fertUser.name = @"Fertility";
    self.fertUser.metrics = [NSArray arrayWithObjects:self.energy, self.nutrition, self.fertilityLevel, self.hormoneBalance, nil];
    
    [self.userTypes addObject:self.fertUser];
    
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
