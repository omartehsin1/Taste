//
//  FoodSearch.m
//  Taste
//
//  Created by Omar Tehsin on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import "FoodSearch.h"

@implementation FoodSearch
- (instancetype)initWithSearchTextField:(NSString *)searchTextField andSearchTextDisplayLabel:(NSString *)searchTextDisplayLabel
{
    self = [super init];
    if (self) {
        self.searchTextField = searchTextField;
        self.searchTextDisplayLabel = searchTextDisplayLabel;
    }
    return self;
}
@end
