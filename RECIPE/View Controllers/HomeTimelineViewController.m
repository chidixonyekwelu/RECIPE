//
//  HomeTimelineViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/6/22.
//

#import "HomeTimelineViewController.h"
#import "RecipeCell.h"
#import "Recipe.h"
#import "RecipeObject.h"
#import "RecipeDetailsViewController.h"
#import "ButtonCellTableViewCell.h"
#import "SceneDelegate.h"
#import "ViewController.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"
#import "RECIPE-Swift.h"

@interface HomeTimelineViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayOfRecipes;
@property (nonatomic, strong) NSArray *searchResults;
@property(strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, retain) NSDate *date;
//@property (nonatomic, strong) TabBarFormat *tabFormat;
@property(readonly) NSUInteger count;

@end

@implementation HomeTimelineViewController{
}
- (IBAction)loadMoreButton:(id)sender {
    for (int i = 0; i < 10; i++)
        [self fetchRecipes];
}
- (IBAction)logOutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"viewController"];
        SceneDelegate *mySceneDelegate = (SceneDelegate *) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
        mySceneDelegate.window.rootViewController = controller;
        NSLog(@"User logged out");
    }];
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchRecipes)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    

    [self fetchRecipes];
    [self fetchParseData];
    
    [self.tableView reloadData];
    
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
        RecipeObject *recipe = self.searchResults[indexPath.row];
        NSLog(@"%@: Recipes", recipe[@"name"]);
        cell.recipeName.text = recipe[@"name"];
        double recipePrice = [recipe[@"price"] doubleValue];
        NSString* formattedRecipePrice = [NSString stringWithFormat:@"%.02f", recipePrice];
        cell.recipePrice.text = [@"Price: $" stringByAppendingString:formattedRecipePrice];
        NSString *URLString = recipe[@"image"];
        NSURL *url = [NSURL URLWithString:URLString];
        [cell.recipePicture setImageWithURL:url];
        
        
        
        
        return cell;

    }
    
    
 
}


- (void) fetchRecipes {
    NSURL *url = [NSURL URLWithString:@"https://api.spoonacular.com/recipes/random?apiKey=56ffff1678d042b3aff0288b3be2e049"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
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
                   RecipeObject *recipeObject = [[RecipeObject alloc] initWithDictionary:dataDictionary[@"recipes"][0]];

                   [self.arrayOfRecipes addObject:recipeObject];
                   NSLog(@"There is length😭😭😭😭😭");
                   NSLog(@"%@", self.arrayOfRecipes);
                   [self updateFilteredMeals];
               } 
               else {
                 
                   NSMutableArray *recipes = [RecipeObject recipesWithArray:dataDictionary[@"recipes"]];
                   self.arrayOfRecipes = recipes;
                   [self updateFilteredMeals];
                   
               }
               
               RecipeObject *recipeInfo = self.arrayOfRecipes[self.arrayOfRecipes.count - 1];
               
               [recipeInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                   if (succeeded) {
                       NSLog(@"Recipes been saved 🥶🥶🥶🥶🥶🥶🥶");
                       [self.tableView reloadData];
                     } else {
                         NSLog(@"Error: %@" , error);
                         NSLog(@"Failed to save, try again later😡🥶🥶🥶");
                     }
               }];
               NSLog(@"recipes");
           
           
               NSLog(@"ARRAY: %@", self.arrayOfRecipes);
               [self.tableView reloadData];
               [self.refreshControl endRefreshing];
           }
       }];
        [task resume];
        
}
                        
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *myCell = sender;
    NSIndexPath *IndexPath = [self.tableView indexPathForCell:myCell];
    RecipeDetailsViewController *recipeDetailVC = [segue destinationViewController];
    recipeDetailVC.recipe = self.searchResults[IndexPath.row];
   
}
 
- (void)fetchParseData{
        PFQuery *query = [PFQuery queryWithClassName:@"RecipeObject"];
        [query orderByAscending:@"createdAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *recipes, NSError *error) {
            if (recipes != nil) {
                self.arrayOfRecipes = (NSMutableArray*) recipes;
                NSLog(@"recipes");
                NSLog(@"ARRAY: %@", self.arrayOfRecipes);

                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
            } else {
                NSLog(@"%@", error.localizedDescription);
            }
        }];
}

- (void)filterContentForSearchText:(NSString* ) searchText
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    _searchResults = [_arrayOfRecipes filteredArrayUsingPredicate:resultPredicate];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self updateFilteredMeals];
    
}

- (void) updateFilteredMeals
{
    
    if([self.searchBar.text  length] > 0) {
        [self filterContentForSearchText:_searchBar.text];
    }
    else{
        _searchResults = _arrayOfRecipes;
    }
        [self.tableView reloadData];
}

- (void) getTodaysDate {
    NSDate* date = [NSDate date];
}

self.tabFormat = [[TabBarFormat alloc] init];
[self.tabFormat changeRadiusOfTabBarItem:self.tabBar];
[self.tabFormat changeUnselectedColor:self.tabBar];
[self.tabFormat changeHeightOfTabbar:self.tabBar];
- (void) tabBar:(UITabBar *)tabBar didSelectItem:(nonnull UITabBarItem *)item {
    [self.tabFormat simpleAnimationWhenSelectItem: item];
}
@end













