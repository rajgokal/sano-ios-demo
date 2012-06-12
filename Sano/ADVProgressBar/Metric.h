//
//  Metric.h
//  Sano
//
//  Created by Raj Gokal on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Metric : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CGFloat score;
@property (nonatomic, assign) CGFloat yesterday;

@end
