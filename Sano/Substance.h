//
//  Substance.h
//  Sano
//
//  Created by Raj Gokal on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h> 

@interface Substance : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, assign) float input;
@property (nonatomic, assign) float min;
@property (nonatomic, assign) float max;
@property (nonatomic, assign) float absoluteMin;
@property (nonatomic, assign) float absoluteMax;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *stateStatus;
@property (nonatomic, strong) NSDate *timeStamp;
@property (nonatomic, strong) NSString *goodSuggestion;
@property (nonatomic, strong) NSString *badSuggestion;

- (UIColor*)colorGrabber;
- (NSString*)iconGrabber;
- (NSString*)stateGrabber;
- (NSString*)stateStatusGrabber;
- (NSString*)suggestionGrabber;
- (id) duplicate;
- (void)createAlert;

@end