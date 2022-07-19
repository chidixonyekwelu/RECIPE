//
//  HomeTimelineViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/6/22.
//

#import "HomeTimelineViewController.h"
#import "RecipeCell.h"
#import "Recipe.h"
#import "RecipeDetailsViewController.h"
#import "SceneDelegate.h"
#import "ViewController.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"

@interface HomeTimelineViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayOfRecipes;
@property(strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation HomeTimelineViewController{
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

    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchRecipes)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    int i;
    for (i = 0; i < 2;i++){
        NSLog(@"recipes");
        [self fetchRecipes];
        [self fetchPricesForID]
    }
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfRecipes.count;
}

- (RecipeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    Recipe *recipe = self.arrayOfRecipes[indexPath.row];
    NSLog(@"RECIPE: %@", recipe.name);
    cell.recipeName.text = recipe.name;
    cell.recipeDescription.text = recipe.instructions;
    cell.recipePrice.text = recipe.price;
    NSString *URLString = recipe.image;
    NSURL *url = [NSURL URLWithString:URLString];
    [cell.recipePicture setImageWithURL:url];
    return cell;
 
}


- (void) fetchRecipes {
    NSURL *url = [NSURL URLWithString:@"https://api.spoonacular.com/recipes/random?apiKey=576edbba44224bb69eac555caa2d3e51"];
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
               if (self.arrayOfRecipes!= nil) {
                   Recipe *recipe = [[Recipe alloc] initWithDictionary:dataDictionary[@"recipes"][0]];
        //           NSLog(@"%@", dataDictionary[@"recipes"][0][@"id"]);
                   [self.arrayOfRecipes addObject:recipe];
                   NSLog(@"%@", self.arrayOfRecipes);
               }
               else {
                   // Array of recipes
                   NSMutableArray *recipes = [Recipe recipesWithArray:dataDictionary[@"recipes"]];
//                   NSLog(@"%@", dataDictionary[@"totalCost"]);
//                   self.arrayOfRecipes = dataDictionary[@"recipes"];
                   self.arrayOfRecipes = recipes;
                   
               }
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
    recipeDetailVC.arrayOfRecipes = self.arrayOfRecipes[IndexPath.row];
   
}



@end













