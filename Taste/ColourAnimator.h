//
//  ColourAnimator.h
//  Taste
//
//  Created by Omar Tehsin on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColourAnimator : NSObject
@property (strong, nonatomic) NSArray *colourWheel;
@property (strong, nonatomic) UIColor *colourChooser;
-(UIColor*)colourGenerator;


@end

NS_ASSUME_NONNULL_END
