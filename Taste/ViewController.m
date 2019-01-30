//
//  ViewController.m
//  Taste
//
//  Created by Omar Tehsin on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import "ViewController.h"
#import "ColourAnimator.h"

@interface ViewController ()
//@property (nonatomic, strong) ColourAnimator *colourAnimator;
@property (weak, nonatomic) IBOutlet UIView *backgroundview;
@property (weak, nonatomic) IBOutlet UIView *textDisplayView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int backgroundLoop = 0;
    ColourAnimator *colourAnimator = [[ColourAnimator alloc]init];
    //self.backgroundview.backgroundColor = [UIColor orangeColor];
    while (backgroundLoop < colourAnimator.colourWheel.count - 1) {
        backgroundLoop++;
        [UIView animateWithDuration:2.5 animations:^{
            self.textDisplayView.backgroundColor = [colourAnimator colourGenerator];
        } completion:NULL];
    }

}

-(void) animateBackgroundColour {
    
}






@end
