//
//  SanoNavigationBar.m
//  Sano
//
//  Created by Raj Gokal on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SanoNavigationBar.h"

@implementation SanoNavigationBar

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"CustomNavBG.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
