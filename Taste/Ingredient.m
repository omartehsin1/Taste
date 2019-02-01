//
//  Ingredient.m
//  Taste
//
//  Created by David on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient
-(instancetype)initWithDictionary:(NSDictionary*)key
{
    self = [super init];
    if (self) {
        self.text = key[@"text"];
        self.image = key[@"image"];
    }
    return self;
}

@end
