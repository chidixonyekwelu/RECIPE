//
//  RecommendationViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/27/22.
//

#import "RecommendationViewController.h"
#import "HomeTimelineViewController.h"
#import "RecipeObject.h"
#import "RecipeCell.h"
#import "UIImageView+AFNetworking.h"
#import "ButtonCellTableViewCell.h"
#import "DateTools.h"

@interface RecommendationViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *recommendationTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSMutableArray *arrayOfRecipes;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) NSString *usersAge;
@property (nonatomic, strong) NSString *usersWeight;
@property(strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, retain) NSDate *date;
@property(readonly) NSUInteger count;
@end



@implementation RecommendationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"🥶🥶🥶🥶🥶 : %@",[PFUser.currentUser valueForKey:@"Age"]);
    self.usersAge = [PFUser.currentUser valueForKey:@"age"];
    self.usersWeight = [PFUser.currentUser valueForKey:@"weight"];
    self.recommendationTableView.delegate = self;
    self.recommendationTableView.dataSource = self;
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetch)
                  forControlEvents:UIControlEventValueChanged];
    [self.recommendationTableView addSubview:self.refreshControl];
    
    NSString *christmasStartDate = @"20221201";
    NSString *christmasEndDate = @"2022015";
    NSString *summerStartDate = @"20220601";
    NSString *summerEndDate = @"20220820";
    NSString *thanksgivingStartDate = @"20221124";
    NSString *thanksgivingEndDate = @"20221201";
    NSString *easterStartDate = @"20220409";
    NSString *easterEndDate = @"20220416";
    
    
    
    int maxCalories;
    int minCalories;
    NSString *foodType;
    if(self.usersAge.intValue <= 30 && self.usersWeight.intValue <= 50 )
    {
        maxFat = 300;
        minFat = 200;
        minCalories = 400;
        maxCalories = 600;
        NSLog(@"Here are the recipes in that calories range", _arrayOfRecipes);
    }
    else{
        minCalories = 100;
        maxCalories = 300;
    }
    [self fetchRecommendationsUsingDates];
    [self.recommendationTableView reloadData];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.arrayOfRecipes.count;

    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    RecipeObject *recipe = self.arrayOfRecipes[indexPath.row];
    NSLog(@"%@: Recipes", recipe[@"name"]);
    cell.recommendationRecipeName.text = recipe[@"name"];
    cell.recommendationRecipePrice.text = [@"Price: $" stringByAppendingString:recipe[@"price"]];
//  NSString* formattedNumber = [NSString stringWithFormat:@"%@", self.recipe.price];
    NSString *URLString = recipe[@"image"];
    NSURL *url = [NSURL URLWithString:URLString];
    [cell.recommendationRecipeImage setImageWithURL:url];
    return cell;
 
}



    
    
 
- (void)fetchRecipeUsingAgeAndMaxCalories:(int )maxCalories fetchRecipeUsingAgeAndMinCalories: (int) minCalories fetchRecipeUsingAgeAndFoodType: (NSString *)foodType {
    NSString *str = [NSString stringWithFormat:@"https://api.spoonacular.com/recipes/complexSearch?query=%@minCalories=%d&number=10&maxCalories=%d&apiKey=86a3c720d5e04f2ea73e3b2dd6b22eb3" , foodType, minCalories, maxCalories];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
{
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No connection"
                                           message:@"Network Request Failed"
                                           preferredStyle:UIAlertControllerStyleAlert];
             
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleDefault
               handler:^(UIAlertAction * action) {}];
             
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"DICTIONARY: %@", dataDictionary);
            [self.activityIndicator stopAnimating];
             
            if (self.arrayOfRecipes.count != 0) {
                RecipeObject *recipeObject = [[RecipeObject alloc] initWithDictionary:dataDictionary[@"results"][0]];

                [self.arrayOfRecipes addObject:recipeObject];
                NSLog(@"There is length😭😭😭😭😭");
                NSLog(@"%@", self.arrayOfRecipes);
            }
            else {

                NSMutableArray *recipes = [RecipeObject recipesWithArray:dataDictionary[@"results"]];
                self.arrayOfRecipes = recipes;

            }
            
            RecipeObject *recipeInfo = self.arrayOfRecipes[self.arrayOfRecipes.count - 1];

            [recipeInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    NSLog(@"Recipes been saved 🥶🥶🥶🥶🥶🥶🥶");
                    [self.recommendationTableView reloadData];
                  } else {
                      NSLog(@"Error: %@" , error);
                      NSLog(@"Failed to save, try again later😡🥶🥶🥶");
                  }
            }];
            NSLog(@"results");


            NSLog(@"ARRAY: %@", self.arrayOfRecipes);
            [self.recommendationTableView reloadData];
            [self.refreshControl endRefreshing];
        }
    }];
     [task resume];
}


- (void) fetchRecommendationsUsingDates{
    NSString *christmasStartDate = @"20221201";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    
    NSDate *dateforStartChristmas = [dateFormat dateFromString:christmasStartDate];
    NSDate *dateforEndChristmas = [dateFormat dateFromString:christmasStartDate];
  
    NSString *summerStartDate = @"20220601";
    NSDate *dateForStartSummer = [dateFormat dateFromString:summerStartDate];
    
    NSString *summerEndDate = @"20220820";
    NSDate *dateForEndSummer = [dateFormat dateFromString:summerEndDate];
    
    NSString *thanksgivingStartDate = @"20221124";
    NSDate *dateforStartThanksgiving = [dateFormat dateFromString:thanksgivingStartDate];
    
    NSString *thanksgivingEndDate = @"20221201";
    NSDate *dateForEndThanksgiving = [dateFormat dateFromString:thanksgivingEndDate];
    
    NSString *easterStartDate = @"20220409";
    NSDate *dateforStartEaster = [dateFormat dateFromString:easterStartDate];
    
    NSString *easterEndDate = @"20220416";
    NSDate *dateForEndEaster = [dateFormat dateFromString:summerEndDate];
    
    int maxCalories;
    int minCalories;
    minCalories = 400;
    maxCalories = 600;
    
    
    if ([self date:self.date isBetweenDate:dateforStartEaster andDate:dateForEndEaster]){

        [self fetchRecipeUsingAgeAndMaxCalories:maxCalories fetchRecipeUsingAgeAndMinCalories:minCalories fetchRecipeUsingAgeAndFoodType:@"Turkey"];
    }
    else if ([self date:self.date isBetweenDate:dateforStartThanksgiving andDate:dateForEndThanksgiving]){
        
        [self fetchRecipeUsingAgeAndMaxCalories:maxCalories fetchRecipeUsingAgeAndMinCalories:minCalories fetchRecipeUsingAgeAndFoodType:@"Macaroni"];
    }
    else if ([self date:self.date isBetweenDate:dateForStartSummer andDate:dateForEndSummer]){
        
        [self fetchRecipeUsingAgeAndMaxCalories:maxCalories fetchRecipeUsingAgeAndMinCalories:minCalories fetchRecipeUsingAgeAndFoodType:@"Burger"];
    }
    else if ([self date:self.date isBetweenDate:dateForStartSummer andDate:dateForEndSummer]){
        
        [self fetchRecipeUsingAgeAndMaxCalories:maxCalories fetchRecipeUsingAgeAndMinCalories:minCalories fetchRecipeUsingAgeAndFoodType:@"Burger"];
    }
    else {
        
        [self fetchRecipeUsingAgeAndMaxCalories:maxCalories fetchRecipeUsingAgeAndMinCalories:minCalories fetchRecipeUsingAgeAndFoodType:nil];
    }

}

- (BOOL)date:(NSDate*)date isBetweenDate:(NSString*)beginDate andDate:(NSString*)endDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
  NS  = [dateFormat dateFromString:endDate];
    = [dateFormat dateFromString:beginDate];
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;

    if ([date compare:endDate] == NSOrderedDescending)
        return NO;

    return YES;
}

@end

