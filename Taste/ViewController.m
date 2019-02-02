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
    
    
    [self addBackgroundBlur];
    [self animatingImages];
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isInTransit = true;
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

-(void)fetchData{
    if (self.search == nil) {
        self.search = @"beef";
    }
    else if (self.search != nil ) {
        self.search = [self.textTyped.text stringByReplacingOccurrencesOfString:@" " withString:@","];
    }
    //c789f525b805ab2555e68d38f5096b6f
    NSString *inPutUrl = [NSString stringWithFormat:@"https://www.food2fork.com/api/search?key=29f2a594050bcf25be3fd8071f18924d&q=%@&page=1", self.search];
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


//-(void)viewDidAppear:(BOOL)animated {
//    self.isInTransit = true;
//}
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

//-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
//    if (event.type == UIEventSubtypeMotionShake) {
//        if (self.isInTransit) {
//            self.isInTransit = false;
//            [self performSegueWithIdentifier:@"cellToDetail" sender:self];
//        }
//    }
//}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if(collectionView == self.ingredientsCollectionVC){
//        self.search = @"chicken";
//        [self fetchData];
//    }
//    
//}

}
@end
