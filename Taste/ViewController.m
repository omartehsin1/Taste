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
#import "UIImage+Blur.h"


@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView* foodCollectionVC;
@property (weak, nonatomic) IBOutlet UICollectionView* ingredientsCollectionVC;
@property (nonatomic) NSArray<Recipe*> * recepiesData;
@property (weak, nonatomic) IBOutlet UITextField *textTyped;
@property (nonatomic) NSMutableArray* recepiesArray;
//@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (nonatomic) NSMutableArray* ingredientsArray;
@property (nonatomic) NSArray* categoriesArray;
@property (nonatomic) NSString* search;
@property (nonatomic) IngredientsData* inData;
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
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic) NSString* stringFromIngredient;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inData = [[IngredientsData alloc]init];
    [self ingredientDataformatter];
    //[self animateBackgroundColour];
    //[self performBackgroundFade];
    self.foodCollectionVC.backgroundColor = [UIColor clearColor];
//    self.categoryView.layer.cornerRadius = 15;
//    self.categoryView.layer.masksToBounds = true;
    
    self.foodCollectionVC.dataSource = self;
    self.foodCollectionVC.delegate = self;
    self.ingredientsCollectionVC.dataSource = self;
    self.ingredientsCollectionVC.delegate = self;
    
   [self fetchData];
    self.arrayData = [[NSMutableArray alloc]init];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLabelFromTextField:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isInTransit = true;
    [self addBackgroundBlur];
    [self animatingImages];
}

-(void)animatingImages {
    self.backgroundImageView.animationImages = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"burger.png"], [UIImage imageNamed:@"burger2.png"], [UIImage imageNamed:@"pasta.png"], [UIImage imageNamed:@"pizza.png"], nil];
    self.backgroundImageView.animationRepeatCount = 1000;
    self.backgroundImageView.animationDuration = 5;
    [self.backgroundImageView startAnimating];
}


-(void)addBackgroundBlur {

    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualEffectView.frame = self.backgroundImageView.bounds;
    visualEffectView.alpha = 1.0f;
    
    [self.backgroundImageView addSubview:visualEffectView];
}
-(void)inputSelector{
    if (self.stringFromIngredient == nil){
        self.search = self.textTyped.text;
    }
        NSLog(@"At method: %@",self.search);
    self.search = [self.search stringByReplacingOccurrencesOfString:@" " withString:@","];
}

-(void)fetchData{
    [self inputSelector];
    //c789f525b805ab2555e68d38f5096b6f
    //1aae8d12cab0f476475ea76b9b4cb637
    //83bb7768cfd05a64993c12882f886084
    //7df844880c4f009dd6512ddf139787ba
    NSString *inPutUrl = [NSString stringWithFormat:@"https://www.food2fork.com/api/search?key=7df844880c4f009dd6512ddf139787ba&q=%@&page=1", self.search];
    NSLog(@"%@", inPutUrl);
    //NSString *inPutUrl = [NSString stringWithFormat:@"https://www.food2fork.com/api/search?key=29f2a594050bcf25be3fd8071f18924d&q=%@&page=1", self.search];
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
        self.categoriesArray = self.ingredientsArray;
    }
}

#pragma mark - Collection View Delegate
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (collectionView == self.foodCollectionVC) {
        RecipeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recipeCell" forIndexPath:indexPath];
        cell.tag = indexPath.item;
        cell.recipe = self.recepiesData[indexPath.item];
        [cell.recipe loadImage];
        return cell;
    } else {
        IngredientCollectionViewCell* inCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ingredientCell" forIndexPath:indexPath];
        inCell.tag = indexPath.item;
        inCell.ingredient = self.ingredientsArray[indexPath.item];
        self.search = inCell.ingredient.text;
        return inCell;
    }
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.foodCollectionVC){
        return self.recepiesData.count;
    } else {
        return self.ingredientsArray.count;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
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

//-(void)viewDidAppear:(BOOL)animated {
//    self.isInTransit = true;
//}
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        if (self.isInTransit) {
            int randIdx = arc4random_uniform(5);
            NSLog(@"%i",randIdx);
            RecipeCollectionViewCell *ascell = [self.foodCollectionVC cellForItemAtIndexPath:[NSIndexPath indexPathForItem:randIdx inSection:0]];
            [self.foodCollectionVC reloadData];
            [self performSegueWithIdentifier:@"cellToDetail" sender: ascell];
            NSLog(@"shook!");
            self.isInTransit = false;
        }
}
}
//-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
//    if (event.type == UIEventSubtypeMotionShake) {
//        if (self.isInTransit) {
//            self.isInTransit = false;
//            [self performSegueWithIdentifier:@"cellToDetail" sender:self];
//        }
//    }
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.ingredientsCollectionVC){
        //self.textTyped.text = @"";
        Ingredient* thisIngredient = self.categoriesArray[indexPath.item];
        NSString* selectedIngredient = thisIngredient.text;
        self.stringFromIngredient = selectedIngredient;
        self.search = self.stringFromIngredient;
        NSLog(@"At Cell :%@",self.search);
        [self fetchData];
        self.stringFromIngredient = nil;
        self.textTyped.text = @"";
    }
}

@end
