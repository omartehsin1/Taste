//
//  Recipe.h
//  Taste
//
//  Created by David on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Recipe : NSObject
@property (nonatomic) NSString* label;
@property (nonatomic) NSString* imageURl;
@property (nonatomic) NSString* url;
@property (nonatomic) UIImage * image;
@property(nonatomic, strong) NSURLSessionTask *imageTask;

-(void)loadImage;

- (instancetype)initWithJsonDictionary:(NSDictionary*)key;
+ (Recipe *)fromJsonDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
