//
//  IngredientsData.m
//  Taste
//
//  Created by David on 2019-02-01.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import "IngredientsData.h"
#import <UIKit/UIKit.h>

@implementation IngredientsData
@synthesize data = _data;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.data = [[NSArray alloc]initWithObjects:
                @{@"text":@"tacos",@"image":@"🌮"},
                @{@"text":@"sishi",@"image":@"🍱"},
                @{@"text":@"pasta",@"image":@"🍜"},
                @{@"text":@"spanish",@"image":@"🍛"},
                @{@"text":@"chicken",@"image":@"🍗"},
                @{@"text":@"avocado",@"image":@"🥑"},
                @{@"text":@"salad",@"image":@"🥗"},
                @{@"text":@"cheese",@"image":@"🧀"},
                @{@"text":@"burger",@"image":@"🍔"},
                @{@"text":@"steak",@"image":@"🥩"},
                @{@"text":@"pork",@"image":@"🍖"},
                @{@"text":@"banana",@"image":@"🍌"},
                @{@"text":@"bacon",@"image":@"🥓"},
                @{@"text":@"carrot",@"image":@"🥕"},
                @{@"text":@"pizza",@"image":@"🍕"},
                @{@"text":@"fries",@"image":@"🍟"},
                @{@"text":@"bread",@"image":@"🍞"},
                @{@"text":@"chinese",@"image":@"🥡"},
                @{@"text":@"tea",@"image":@"🍵"},
                @{@"text":@"cocktail",@"image":@"🍹"},
                @{@"text":@"chocolate",@"image":@"🍫"},
                @{@"text":@"cake",@"image":@"🎂"},
                @{@"text":@"milk",@"image":@"🥛"},
                @{@"text":@"corn",@"image":@"🌽"},
                @{@"text":@"egg",@"image":@"🥚"},
                @{@"text":@"fish",@"image":@"🐟"},
                @{@"text":@"coconut",@"image":@"🥥"},
                @{@"text":@"lemon",@"image":@"🍋"},
                @{@"text":@"soup",@"image":@"🍲"},
                @{@"text":@"broccoli",@"image":@"🥦"},
                @{@"text":@"honey",@"image":@"🍯"},
                @{@"text":@"pineaple",@"image":@"🍍"},
                @{@"text":@"strawberry",@"image":@"🍓"},
                @{@"text":@"watermelon",@"image":@"🍉"},
                @{@"text":@"apple",@"image":@"🍎"},
                @{@"text":@"chocolate",@"image":@"🦀"},
                @{@"text":@"tomatoe",@"image":@"🍅"},
                @{@"text":@"cucumber",@"image":@"🥒"},
                @{@"text":@"peper",@"image":@"🌶"},
                @{@"text":@"letuce",@"image":@"🥬"},
                @{@"text":@"eggplant",@"image":@"🍆"},
                @{@"text":@"lobster",@"image":@"🦞"},
                @{@"text":@"shrimp",@"image":@"🍤"},
                @{@"text":@"rice",@"image":@"🍚"},
                @{@"text":@"grapes",@"image":@"🍇"},
                nil];
    }
    return self;
}


@end
