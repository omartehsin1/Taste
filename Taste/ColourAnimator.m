//
//  ColourAnimator.m
//  Taste
//
//  Created by Omar Tehsin on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import "ColourAnimator.h"
#import <UIKit/UIKit.h>


@implementation ColourAnimator

-(UIColor*)colourGenerator {
    //create three colour wheen arrays, put them into one, create a for-in loop
    UIColor *red = [UIColor colorWithRed:(255.0/255.0) green:(47.0/255.0) blue:(71.0/255.0) alpha:0.8];
    UIColor *orange = [UIColor colorWithRed:(255.0/255.0) green:(127.0/255.0) blue:(47.0/255.0) alpha:0.8];
    UIColor *yellow = [UIColor colorWithRed:(255.0/255.0) green:(231.0/255.0) blue:(47.0/255.0) alpha:0.8];
    
    NSArray *colourWheel = @[red, orange, yellow];
    
    
    for (UIColor *colour in colourWheel) {
        self.colourChooser = colour;
    }
    
    return self.colourChooser;
    
}
@end
