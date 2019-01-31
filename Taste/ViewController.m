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

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView* foodCollectionVC;
@property (nonatomic) NSArray<Recipe*> * recepiesData;
@property (weak, nonatomic) IBOutlet UITextField *textTyped;

@property (nonatomic) NSMutableArray* recepiesArray;
@property (nonatomic) NSString* search;
@property (nonatomic) NSString* displayText;
@property (nonatomic) NSArray *recipes;
@property (nonatomic) NSArray *searchResults;
@property (weak, nonatomic) IBOutlet UIView *backgroundview;
@property (weak, nonatomic) IBOutlet UIView *textDisplayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self animateBackgroundColour];
    self.foodCollectionVC.dataSource = self;
    self.foodCollectionVC.delegate = self;
    if (self.search == nil) {
        self.search = @"chicken";
    }
   [self fetchData];
}
-(void)fetchData{
    if (self.search == nil) {
        self.search = @"beef";
    }
    else if (self.search != nil ) {
        self.search = self.textTyped.text;    
    }
    NSString *inPutUrl = [NSString stringWithFormat:@"https://www.food2fork.com/api/search?key=1aae8d12cab0f476475ea76b9b4cb637&q=%@&page=1", self.search];
    //NSString *inPutUrl = @"https://www.food2fork.com/api/search?key=29f2a594050bcf25be3fd8071f18924d&q=chicken%20breast&page=2";
    //NSURL *url = [NSURL URLWithString:@"https://www.food2fork.com/api/search?key=29f2a594050bcf25be3fd8071f18924d&q=chicken%20breast&page=2"];
    NSURL* url = [NSURL URLWithString:inPutUrl];
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


#pragma mark - Collection View Delegate
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RecipeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recipeCell" forIndexPath:indexPath];
    cell.tag = indexPath.item;
    cell.recipe = self.recepiesData[indexPath.item];
    [cell.recipe loadImage];
    
    return cell;
}



- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recepiesData.count;
}



-(void) animateBackgroundColour {
    ColourAnimator *colourAnimator = [[ColourAnimator alloc]init];
    [UIView animateWithDuration:2.5 animations:^{
        //        RecipeCollectionViewCell *rcv = [[RecipeCollectionViewCell alloc]init];
        //        rcv.backgroundColor = [colourAnimator colourGenerator];
        self.backgroundview.backgroundColor = [colourAnimator colourGenerator];
        self.textDisplayView.backgroundColor = [colourAnimator colourGenerator];
        
    } completion:NULL];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString* str = [[NSString alloc]init];
    [str stringByReplacingOccurrencesOfString:@" " withString:@","];
    self.search = str;
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



@end
