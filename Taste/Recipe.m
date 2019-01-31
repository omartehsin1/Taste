//
//  Recipe.m
//  Taste
//
//  Created by David on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

- (instancetype)initWithJsonDictionary:(NSDictionary*)key;
{
    self = [super init];
    if (self) {
        self.lable = key[@"lable"];
        self.imageURl = key[@"image"];
        self.url = key[@"url"];
        self.shareAs = key[@"shareAs"];
        self.yield = [key[@"yeild"] integerValue];
        self.ingredientLines = key[@"ingridientLines"];
        self.calories = [key[@"calories"] floatValue];
    }
    return self;
}

+ (Recipe *)fromJsonDictionary:(NSDictionary *)dictionary{
    Recipe* theRecipe = [[Recipe alloc]initWithJsonDictionary:dictionary];
    return theRecipe;
}
@end
