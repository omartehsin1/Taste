//
//  RecipeCollectionViewCell.m
//  Taste
//
//  Created by David on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import "RecipeCollectionViewCell.h"

@interface RecipeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel* foodLabel;
@property (weak, nonatomic) IBOutlet UIImageView* foodImage;

@end

@implementation RecipeCollectionViewCell


-(void)awakeFromNib {
    [super awakeFromNib];
    [self addObserver:self forKeyPath:@"self.recipe.image" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:nil];
}

-(void)dealloc {
    [self removeObserver:self forKeyPath:@"self.recipe.image"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"self.recipe.image"]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.foodImage.image = self.recipe.image;
        }];
    }
    
}

-(void)setRecipe:(Recipe *)recipe{
    _recipe = recipe;
    self.foodLabel.text = recipe.label;
    self.foodImage.image = recipe.image;
}


@end
