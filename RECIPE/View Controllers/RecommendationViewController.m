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
@property (nonatomic) NSInteger maxCalories;
@property (nonatomic) NSInteger minCalories;
@property(strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, retain) NSDate *date;
@property(readonly) NSUInteger count;
@end



@implementation RecommendationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"🥶🥶🥶🥶🥶 : %@",[PFUser.currentUser valueForKey:@"Age"]);
    self.usersAge = [PFUser.currentUser valueForKey:@"age"];
    self.recommendationTableView.delegate = self;
    self.recommendationTableView.dataSource = self;
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetch)
                  forControlEvents:UIControlEventValueChanged];
    [self.recommendationTableView addSubview:self.refreshControl];
    
//    [self fetchRecipeUsingAgeAndMaxCalories:_maxCalories fetchRecipeUsingAgeAndMinCalories:_minCalories fetchRecipeUsingQuery:foodkey];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.arrayOfRecipes.count ;

    
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



    
    
 
- (void)fetchRecipeUsingAgeAndMaxCalories:(NSString *)maxCalories fetchRecipeUsingAgeAndMinCalories: (NSString *)minCalories fetchRecipeUsingQuery:(NSString *)foodType {
    NSString *str = [NSString stringWithFormat:@"https://api.spoonacular.com/recipes/complexSearch?query=%@&minCalories=%@&number=2&maxCalories=%@&apiKey=86a3c720d5e04f2ea73e3b2dd6b22eb3" ,foodType, minCalories, maxCalories ];
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
            
            if(self.usersAge.intValue <= 30)
                self.minCalories = 200;
                self.maxCalories = 500;
                NSLog(@"Here are the recipes in that calories range", _arrayOfRecipes);
            }
       
            if (self.arrayOfRecipes.count != 0) {
//                RecipeObject *recipeObject = [[RecipeObject alloc] initWithDictionary:dataDictionary[@"recipes"][0]];

//                [self.arrayOfRecipes addObject:recipeObject];
                NSLog(@"There is length😭😭😭😭😭");
                NSLog(@"%@", self.arrayOfRecipes);
            }
            else {

//                NSMutableArray *recipes = [RecipeObject recipesWithArray:dataDictionary[@"recipes"]];
//                self.arrayOfRecipes = recipes;

            }
//
//            RecipeObject *recipeInfo = self.arrayOfRecipes[self.arrayOfRecipes.count - 1];
//
//            [recipeInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//                if (succeeded) {
//                    NSLog(@"Recipes been saved 🥶🥶🥶🥶🥶🥶🥶");
//                    [self.recommendationTableView reloadData];
//                  } else {
//                      NSLog(@"Error: %@" , error);
//                      NSLog(@"Failed to save, try again later😡🥶🥶🥶");
//                  }
//            }];
//            NSLog(@"recipes");
//
//
//            NSLog(@"ARRAY: %@", self.arrayOfRecipes);
//            [self.recommendationTableView reloadData];
//            [self.refreshControl endRefreshing];
//        }
    }];
     [task resume];
//
}

//
//- (void) getNSDates{
////       NSDate *date= [NSDate date];
//       NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//       [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//
//    NSString *christmas;
//    NSString *summer;
//    NSString *thanksgiving;
//    NSString *easter;
//
//    christmas =  @"2022-12-01 to 2022-01-5";
//    summer = @"2022-06-01 to 2022-08-20";
//    thanksgiving = @"2022-11-24 to 2022-12-1";
//    easter = @"2022-04-09 to 2022-04-16";
//
//
//}
//
//
//+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
//{
//    if ([date compare:beginDate] == NSOrderedAscending)
//        return NO;
//
//    if ([date compare:endDate] == NSOrderedDescending)
//        return NO;
//
//    return YES;
//}
            
//}

@end

