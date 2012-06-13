//
//  Substance.m
//  Sano
//
//  Created by Raj Gokal on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Substance.h"
#import "MyManager.h"

@implementation Substance

@synthesize name,filename,notes,input,min,max,color,unit,state,stateStatus,timeStamp,goodSuggestion,badSuggestion,absoluteMax,absoluteMin;

- (UIColor*)colorGrabber
{
    if (input>max) {
        return [UIColor colorWithRed:0.741 green:0.102 blue:0 alpha:1] /*#bd1a00*/;
    }
    if (input<min) {
        return [UIColor colorWithRed:1 green:0.729 blue:0 alpha:1] /*#ffba00*/;
    }
    return [UIColor colorWithRed:0.522 green:0.773 blue:0.533 alpha:1] /*#85c588*/;
}

- (NSString*)iconGrabber
{
    if (input>self.max) {
        return @"Indicator Spot - Red.png";
    }
    if (input<self.min) {
        return @"Indicator Spot - Yellow.png";
    }
    return @"Indicator Spot - Green.png";
}

- (NSString*)stateGrabber
{
    
    if (input>max) {
        float percentage = fabsf(((float)self.input/self.max-1)*100);
        return [NSString stringWithFormat:@"%0.0f%%", percentage];
    }
    if (input<min) {
        float percentage = fabsf(((float)self.input/self.max-1)*100);
        return [NSString stringWithFormat:@"%0.0f%%", percentage];
    }
        return @"GOOD";
}

- (NSString*)suggestionGrabber
{
    
    if (self.input>self.max) {
        return badSuggestion;
    }
    if (self.input<self.min) {
        return goodSuggestion;
    }
    return @"GOOD";
}

- (NSString*)stateStatusGrabber
{
    if (self.input>self.max) {
        return @"ABOVE TARGET";
    }
    if (self.input<self.min) {
        return @"BELOW TARGET";
    }
    return @"ON TARGET";
}

- (void)createAlert
{
    MyManager *sharedManager = [MyManager sharedManager];
    [self setTimeStamp:[NSDate date]];
    if ([[sharedManager alerts] count]>=1)
    {
        if ([[[[sharedManager alerts] objectAtIndex:[sharedManager.alerts count]-1] name] isEqualToString:[self name]])
        {
            [sharedManager.alerts replaceObjectAtIndex:[sharedManager.alerts count]-1 withObject:[self duplicate]];
            return;
        }
    }
    [sharedManager.alerts addObject:[self duplicate]];
}

-(id) duplicate
{
    Substance *substanceCopy = [[Substance alloc] init];
    
    [substanceCopy setName:name];
    [substanceCopy setFilename:filename];
    [substanceCopy setNotes:notes];
    [substanceCopy setInput:input];
    [substanceCopy setMin:min];
    substanceCopy.color=color;
    substanceCopy.unit=unit;
    substanceCopy.state=state;
    substanceCopy.stateStatus=stateStatus;
    substanceCopy.timeStamp=timeStamp;
    substanceCopy.goodSuggestion=goodSuggestion;
    substanceCopy.badSuggestion=badSuggestion;
    return substanceCopy;
}

@end
