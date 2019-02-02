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
                @{@"text":@"Tacos",
                  @"image":@"🌮"},
                @{@"text":@"Sushi",
                  @"image":@"🍱"},
                @{@"text":@"Pasta",
                  @"image":@"🍜"},
                @{@"text":@"Spanish",
                  @"image":@"🍛"},
                @{@"text":@"Chicken",@"image":@"🍗"},
                //@{@"text":@"avocado",@"image":@"🥑"},
                @{@"text":@"Salad",@"image":@"🥗"},
                //@{@"text":@"cheese",@"image":@"🧀"},
                @{@"text":@"Burger",@"image":@"🍔"},
                @{@"text":@"Steak",@"image":@"🥩"},
                @{@"text":@"Pork",@"image":@"🍖"},
                //@{@"text":@"banana",@"image":@"🍌"},
                //@{@"text":@"bacon",@"image":@"🥓"},
                //@{@"text":@"carrot",@"image":@"🥕"},
                @{@"text":@"Pizza",@"image":@"🍕"},
                @{@"text":@"Fries",@"image":@"🍟"},
                @{@"text":@"Bread",@"image":@"🍞"},
                @{@"text":@"Chinese",@"image":@"🥡"},
                @{@"text":@"Tea",@"image":@"🍵"},
                @{@"text":@"Cocktail",@"image":@"🍹"},
                @{@"text":@"Chocolate",@"image":@"🍫"},
                @{@"text":@"Cake",@"image":@"🎂"},
                //@{@"text":@"milk",@"image":@"🥛"},
                //@{@"text":@"corn",@"image":@"🌽"},
                //@{@"text":@"egg",@"image":@"🥚"},
                @{@"text":@"Fish",@"image":@"🐟"},
                //@{@"text":@"coconut",@"image":@"🥥"},
                //@{@"text":@"lemon",@"image":@"🍋"},
                @{@"text":@"Soup",@"image":@"🍲"},
                //@{@"text":@"broccoli",@"image":@"🥦"},
                //@{@"text":@"honey",@"image":@"🍯"},
                //@{@"text":@"pineaple",@"image":@"🍍"},
                //@{@"text":@"strawberry",@"image":@"🍓"},
                //@{@"text":@"watermelon",@"image":@"🍉"},
                //@{@"text":@"apple",@"image":@"🍎"},
                @{@"text":@"Crab",@"image":@"🦀"},
                //@{@"text":@"tomatoe",@"image":@"🍅"},
                //@{@"text":@"cucumber",@"image":@"🥒"},
                //@{@"text":@"peper",@"image":@"🌶"},
                //@{@"text":@"letuce",@"image":@"🥬"},
                //@{@"text":@"eggplant",@"image":@"🍆"},
                @{@"text":@"Lobster",@"image":@"🦞"},
                @{@"text":@"Shrimp",@"image":@"🍤"},
                @{@"text":@"Rice",@"image":@"🍚"},
                //@{@"text":@"grapes",@"image":@"🍇"},
                nil];
    }
    return self;
}


@end
