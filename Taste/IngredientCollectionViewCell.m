//
//  IngredientCollectionViewCell.m
//  Taste
//
//  Created by David on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import "IngredientCollectionViewCell.h"

@interface IngredientCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel* textLabel;
@property (weak, nonatomic) IBOutlet UILabel* emojiLabel;

@end

@implementation IngredientCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    self.emojiLabel.layer.masksToBounds = true;
    self.emojiLabel.layer.borderWidth = 1.0;
    self.emojiLabel.layer.cornerRadius = self.emojiLabel.bounds.size.width/4;
}


- (void)setIngredient:(Ingredient *)ingredient{
    self.textLabel.text = ingredient.text;
    self.emojiLabel.text = ingredient.image;
}

@end
