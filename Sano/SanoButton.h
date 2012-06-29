//
//  SanoButton.h
//  Sano
//
//  Created by Raj Gokal on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SanoButton : UIButton {
    UIColor *_highColor;
    UIColor *_lowColor;
    
    CAGradientLayer *gradientLayer;
}

@property (nonatomic, strong) UIColor *_highColor;
@property (nonatomic, strong) UIColor *_lowColor;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

- (void)setHighColor:(UIColor*)color;
- (void)setLowColor:(UIColor*)color;


@end
