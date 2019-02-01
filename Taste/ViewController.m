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
#import "FoodSearch.h"
#import "IngredientsData.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView* foodCollectionVC;
@property (weak, nonatomic) IBOutlet UICollectionView* ingredientsCollectionVC;
@property (nonatomic) NSArray<Recipe*> * recepiesData;
@property (weak, nonatomic) IBOutlet UITextField *textTyped;
@property (nonatomic) NSMutableArray* recepiesArray;
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (nonatomic) NSMutableArray* ingredientsArray;
@property (nonatomic) NSString* search;
@property (nonatomic) IngredientsData* inData;
@property (nonatomic) NSString* displayText;
@property (nonatomic) NSArray *recipes;
@property (nonatomic) NSArray *searchResults;
@property (weak, nonatomic) IBOutlet UIView *backgroundview;
@property (weak, nonatomic) IBOutlet UIView *textDisplayView;
@property (nonatomic) BOOL isInTransit;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inData = [[IngredientsData alloc]init];
    [self ingredientDataformatter];
    //[self animateBackgroundColour];
    //[self performBackgroundFade];
    self.categoryView.layer.cornerRadius = 15;
    self.categoryView.layer.masksToBounds = true;
    
    self.foodCollectionVC.dataSource = self;
    self.foodCollectionVC.delegate = self;
    self.ingredientsCollectionVC.dataSource = self;
    self.ingredientsCollectionVC.delegate = self;
    
   [self fetchData];
}

-(void)viewDidAppear:(BOOL)animated {
    self.isInTransit = true;
}
-(IBAction)buttons:(UIButton*)sender{
    if (sender.tag == 0){
        self.textTyped.text = @"tacos";
    } else if (sender.tag == 1) {
        self.textTyped.text = @"sushi";
    } else if (sender.tag == 2) {
        self.textTyped.text = @"pasta";
    } else if (sender.tag == 3) {
        self.textTyped.text = @"spanish";
    }
    [self fetchData];
    [self.foodCollectionVC reloadData];
}


-(void)fetchData{
    if (self.search == nil) {
        self.search = @"beef";
    }
    else if (self.search != nil ) {
        self.search = [self.textTyped.text stringByReplacingOccurrencesOfString:@" " withString:@","];
    }
    NSString *inPutUrl = [NSString stringWithFormat:@"https://www.food2fork.com/api/search?key=d88efc1cbe97eb8c74f8823dc953eeba&q=%@&page=1", self.search];
    NSURL *url = [NSURL URLWithString:inPutUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL: url];
    NSURLSessionTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^
                              (NSData * _Nullable data,
                               NSURLResponse * _Nullable response,
                               NSError * _Nullable error) {
                                  NSError* jsonError;
                                  NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options: 0 error: &jsonError];
                                  NSArray* recipeObjects = json[@"recipes"];
                                  self.recepiesArray = [[NSMutableArray alloc]init];
                                  for (NSDictionary* recipeDictionary in recipeObjects){
                                      //Recipe* aRecipe = [Recipe fromJsonDictionary:recipeDictionary];
                                      Recipe *aRecipe = [[Recipe alloc]initWithJsonDictionary:recipeDictionary];
                                      [self.recepiesArray addObject:aRecipe];
                                  }
                                  self.recepiesData = self.recepiesArray;
                                  [NSOperationQueue.mainQueue addOperationWithBlock:^{
                                      [self.foodCollectionVC reloadData];
                                  }];
     
                                  }];
    [task resume];
}

-(void)ingredientDataformatter{
    self.ingredientsArray = [[NSMutableArray alloc]init];
    for (NSDictionary* ingredientsDictionary in self.inData.data) {
        Ingredient *theIngredient = [[Ingredient alloc]initWithDictionary:ingredientsDictionary];
        [self.ingredientsArray addObject:theIngredient];
    }
}


#pragma mark - Collection View Delegate
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RecipeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recipeCell" forIndexPath:indexPath];
    cell.tag = indexPath.item;
    cell.recipe = self.recepiesData[indexPath.item];
    [cell.recipe loadImage];
    
    IngredientCollectionViewCell* inCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ingredientCell" forIndexPath:indexPath];
    inCell.tag = indexPath.item;
    inCell.ingredient = self.ingredientsArray[indexPath.item];
    [inCell.ingredient addProperties];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recepiesData.count;
}

//-(void) animateBackgroundColour {
//    ColourAnimator *colourAnimator = [[ColourAnimator alloc]init];
//        self.foodCollectionVC.backgroundColor = [colourAnimator colourGenerator];
//        self.backgroundview.backgroundColor = [colourAnimator colourGenerator];
//        self.textDisplayView.backgroundColor = [colourAnimator colourGenerator];
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    //self.search = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    [self fetchData];
    [self.foodCollectionVC reloadData];
    [self.view endEditing:YES];
    return true;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"cellToDetail"]){
        DetailViewController* dvc = [segue destinationViewController];
        RecipeCollectionViewCell* recipeToSendCell = sender;
        Recipe* recipeFromCell = recipeToSendCell.recipe;
        dvc.recipeInfo = recipeFromCell;
    }

}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        if (self.isInTransit) {
            self.isInTransit = false;
            [self performSegueWithIdentifier:@"cellToDetail" sender:self];
        }
    }
}

//-(void)performBackgroundFade {
//    if (self.backgroundview.alpha == 0.4) {
//        [UIView animateWithDuration:1 animations:^{
//            self.backgroundview.alpha = 1.0;
//        } completion:^(BOOL finished) {
//            [self performBackgroundFade];
//        }];
//    }
//    else if (self.backgroundview.alpha == 1.0) {
//        [UIView animateWithDuration:1 animations:^{
//            self.backgroundview.alpha = 0.3;
//        } completion:^(BOOL finished) {
//            [self performBackgroundFade];
//        }];
//    }
//}

@end
