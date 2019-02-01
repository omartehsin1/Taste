//
//  Ingredient.h
//  Taste
//
//  Created by David on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Ingredient : NSObject
@property (nonatomic) NSString* image;
@property (nonatomic) NSString* text;
-(instancetype)initWithDictionary:(NSDictionary*)key;
@end

NS_ASSUME_NONNULL_END
