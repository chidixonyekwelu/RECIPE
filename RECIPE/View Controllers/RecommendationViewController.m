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

@interface RecommendationViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *recommendationTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSMutableArray *arrayOfRecipes;
@property (nonatomic, strong) NSArray *searchResults;
@property(strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, retain) NSDate *date;
@property(readonly) NSUInteger count;
@end

@implementation RecommendationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recommendationTableView.delegate = self;
    self.recommendationTableView.dataSource = self;
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetch)
                  forControlEvents:UIControlEventValueChanged];
    [self.recommendationTableView addSubview:self.refreshControl];
    
    [self fetchRecipeUsingAge];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.searchResults.count + 1 ;

    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == self.searchResults.count) {
        ButtonCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loadMoreCell" forIndexPath:indexPath];
        NSLog(@"SHOW RECIPES: %@", self.arrayOfRecipes);
        return cell;
    }
    else{
        RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
        RecipeObject *recipe = self.arrayOfRecipes[indexPath.row];
        NSLog(@"%@: Recipes", recipe[@"name"]);
        cell.recommendationRecipeName.text = recipe[@"name"];
        cell.recommendationRecipePrice.text = [@"Price: $" stringByAppendingString:recipe[@"price"]];
//        NSString* formattedNumber = [NSString stringWithFormat:@"%@", self.recipe.price];
        NSString *URLString = recipe[@"image"];
        NSURL *url = [NSURL URLWithString:URLString];
        [cell.recommendationRecipeImage setImageWithURL:url];
        
        
        
        
        return cell;

    }
    
    
 
}
- (void)fetchRecipeUsingAge {
    NSURL *url = [NSURL URLWithString:@"https://api.spoonacular.com/recipes/complexSearch?apiKey=86a3c720d5e04f2ea73e3b2dd6b22eb3"];
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
            
//            if the users age is less than 20, show recipes with more than 100 calories,
//                if the users age is 20 to 40, show recipes from 50 to 100 calories,
//                if the users age is more than 50, show calories less than 50
                    
            if (self.arrayOfRecipes.count != 0) {
                RecipeObject *recipeObject = [[RecipeObject alloc] initWithDictionary:dataDictionary[@"recipes"][0]];

                [self.arrayOfRecipes addObject:recipeObject];
                NSLog(@"There is length😭😭😭😭😭");
                NSLog(@"%@", self.arrayOfRecipes);
            }
            else {
              
                NSMutableArray *recipes = [RecipeObject recipesWithArray:dataDictionary[@"recipes"]];
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
            NSLog(@"recipes");
        
        
            NSLog(@"ARRAY: %@", self.arrayOfRecipes);
            [self.recommendationTableView reloadData];
            [self.refreshControl endRefreshing];
        }
    }];
     [task resume];
     
}

//- (void) get
            
            

@end
