//
//  ViewController.m
//  Taste
//
//  Created by David on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import "ViewController.h"
#import "ColourAnimator.h"


#import "Recipe.h"
#import "RecipeCollectionViewCell.h"
#import "Ingredient.h"
#import "IngredientCollectionViewCell.h"
#import "DetailViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView* foodCollectionVC;
@property (nonatomic) NSArray<Recipe*> * recepiesData;
@property (nonatomic) NSMutableArray* recepies;
@property (nonatomic) NSString* search;
//@property (nonatomic, strong) ColourAnimator *colourAnimator;
@property (weak, nonatomic) IBOutlet UIView *backgroundview;
@property (weak, nonatomic) IBOutlet UIView *textDisplayView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int backgroundLoop = 0;
    ColourAnimator *colourAnimator = [[ColourAnimator alloc]init];
    //self.backgroundview.backgroundColor = [UIColor orangeColor];
//    while (backgroundLoop < colourAnimator.colourWheel.count - 1) {
//        backgroundLoop++;
//        [UIView animateWithDuration:2.5 animations:^{
//            self.textDisplayView.backgroundColor = [colourAnimator colourGenerator];
//        } completion:NULL];
//    }
    self.foodCollectionVC.dataSource = self;
    self.foodCollectionVC.delegate = self;
    [self fetchData];
}

-(void)fetchData{
    // https://api.edamam.com/search?q={ingredients go here}&app_id=ecacded3&app_key=935ae12374e7cbb6f82dc1b513aa7dbb
    if (self.search == nil) {
        self.search = @"chicken";
    }
    NSString* inPutUrl = [NSString stringWithFormat: @"https://api.edamam.com/search?q=%@&app_id=ecacded3&app_key=935ae12374e7cbb6f82dc1b513aa7dbb", self.search];
    NSURL* url = [NSURL URLWithString:inPutUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL: url];
    NSURLSessionTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^
                              (NSData * _Nullable data,
                               NSURLResponse * _Nullable response,
                               NSError * _Nullable error) {
                                  NSError* jsonError;
                                  NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options: 0 error: &jsonError];
                                  NSArray* recipeObjects = json[@"hits"][@"recipe"];
                                  self.recepies = [[NSMutableArray alloc]init];
                                  for (NSDictionary* recipeDictionary in recipeObjects){
                                      Recipe* aRecipe = [Recipe fromJsonDictionary:recipeDictionary];
                                      [self.recepies addObject:aRecipe];
                                  }
                                  self.recepiesData = self.recepies;
                                  [NSOperationQueue.mainQueue addOperationWithBlock:^{
                                      [self.foodCollectionVC reloadData];
                                  }];
                              }];
    [task resume];
}



- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RecipeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recipeCell" forIndexPath:indexPath];
    cell.tag = indexPath.item;
    cell.recipe = self.recepiesData[indexPath.item];
    
    return cell;
}

-(void) animateBackgroundColour {
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recepiesData.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailViewController* dvc = [segue destinationViewController];
    RecipeCollectionViewCell* recipeToSendCell = sender;
    Recipe* recipeFromCell = recipeToSendCell.recipe;
    dvc.recipeInfo = recipeFromCell;
}


@end
