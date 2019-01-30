//
//  RecipeCollectionViewCell.h
//  Taste
//
//  Created by David on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecipeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) Recipe* recipe;

@end

NS_ASSUME_NONNULL_END
