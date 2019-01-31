//
//  FoodSearch.h
//  Taste
//
//  Created by Omar Tehsin on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoodSearch : NSObject
@property(nonatomic, strong) NSString *searchTextField;
@property(nonatomic, strong) NSString *searchTextDisplayLabel;
-(instancetype)initWithSearchTextField: (NSString *)searchTextField andSearchTextDisplayLabel:(NSString *) searchTextDisplayLabel;
@end

NS_ASSUME_NONNULL_END
