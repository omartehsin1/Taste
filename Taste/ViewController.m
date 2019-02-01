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
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (nonatomic) NSString* search;
@property (nonatomic) NSString* displayText;
@property (nonatomic) NSArray *recipes;
@property (nonatomic) NSArray *searchResults;
@property (weak, nonatomic) IBOutlet UIView *backgroundview;
@property (weak, nonatomic) IBOutlet UIView *textDisplayView;
@property (nonatomic) BOOL isInTransit;
@property (weak, nonatomic) IBOutlet UILabel *ingredientLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *ingredientLabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *ingredientLabelThree;
@property (weak, nonatomic) IBOutlet UILabel *ingredientLabelFour;
@property (nonatomic, strong) NSArray<NSString *> *arrayData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.foodCollectionVC.backgroundColor = [UIColor clearColor];
    self.categoryView.layer.cornerRadius = 15;
    self.categoryView.layer.masksToBounds = true;
    self.foodCollectionVC.dataSource = self;
    self.foodCollectionVC.delegate = self;

   [self fetchData];
    self.arrayData = [[NSMutableArray alloc]init];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLabelFromTextField:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
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
    NSString *inPutUrl = [NSString stringWithFormat:@"https://www.food2fork.com/api/search?key=3c58b6311ac0bf81c8cb97ebcb3be5ee&q=%@&page=1", self.search];
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



//-(void) animateBackgroundColour {
//    static NSInteger i = 0;
//    NSArray *colours = [NSArray arrayWithObjects:[UIColor colorWithRed:(240.0/255.0) green:(171.0/255.0) blue:(141.0/255.0) alpha:1.0], [UIColor colorWithRed:(89/255.0) green:(47.0/255.0) blue:(88.0/255.0) alpha:1.0], [UIColor colorWithRed:(235.0/255.0) green:(38.0/255.0) blue:(50.0/255.0) alpha:1.0], nil];
//    if (i >= [colours count]) {
//        i = 0;
//    }
//    [UIView animateWithDuration:2.0 animations:^{
//        self.backgroundview.backgroundColor = [colours objectAtIndex:i];
//    } completion:^(BOOL finished) {
//        i++;
//    }];
//
//}



-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    //self.search = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    [self fetchData];
    [self.foodCollectionVC reloadData];
    [self.view endEditing:YES];
    
    return true;
}


- (void)updateLabelFromTextField:(NSNotification *)notification{
 
    if (notification.object == self.textTyped){
        self.textTyped = (UITextField *) notification.object;
        self.arrayData = [self.textTyped.text componentsSeparatedByString:@" "];

        NSArray<UILabel*>* labels = @[self.ingredientLabelOne, self.ingredientLabelTwo,
                                      self.ingredientLabelThree, self.ingredientLabelFour];
        [self.arrayData enumerateObjectsUsingBlock:^(NSString * word, NSUInteger idx, BOOL * _Nonnull stop) {
            labels[idx].text = word;
        }];

    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"cellToDetail"]){
        DetailViewController* dvc = [segue destinationViewController];
        RecipeCollectionViewCell* recipeToSendCell = sender;
        Recipe* recipeFromCell = recipeToSendCell.recipe;
        dvc.recipeInfo = recipeFromCell;
    }
}


-(void)viewDidAppear:(BOOL)animated {
    self.isInTransit = true;
}
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        if (self.isInTransit) {
            int randIdx = arc4random_uniform([self.foodCollectionVC numberOfItemsInSection:0]);
            UICollectionViewCell *cell = [self.foodCollectionVC cellForItemAtIndexPath:[NSIndexPath indexPathForItem:randIdx inSection:0]];
            [self performSegueWithIdentifier:@"cellToDetail" sender:cell];
            NSLog(@"shook!");
            self.isInTransit = false;
        }
    }
}


@end
