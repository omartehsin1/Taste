//
//  RecipeCollectionViewCell.m
//  Taste
//
//  Created by David on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import "RecipeCollectionViewCell.h"

@interface RecipeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel* foodLable;
@property (weak, nonatomic) IBOutlet UIImageView* foodImage;

@end



@implementation RecipeCollectionViewCell

-(void)setRecipe:(Recipe *)recipe{
    _recipe = recipe;
    self.foodLable.text = recipe.label;
    self.foodImage.image = recipe.image;
}


@end
