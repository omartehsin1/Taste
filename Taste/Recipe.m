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
        self.label = key[@"title"];
        self.imageURl = key[@"image_url"];
        self.url = key[@"source_url"];
        //self.shareAs = key[@"shareAs"];
        //self.yield = [key[@"yeild"] integerValue];
        //self.ingredientLines = key[@"ingredientLines"];
        //self.calories = [key[@"calories"] floatValue];
    }
    return self;
}

+ (Recipe *)fromJsonDictionary:(NSDictionary *)dictionary{
    Recipe* theRecipe = [[Recipe alloc]initWithJsonDictionary:dictionary];
    return theRecipe;
}

-(void)loadImage {
    if (!self.image) {}
        NSURL *imageURL = [NSURL URLWithString:self.imageURl];
        NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
        self.imageTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage *image = [UIImage imageWithData:data];
            self.image = image;
        }];
        [self.imageTask resume];
}
@end
