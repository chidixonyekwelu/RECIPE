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
- (IBAction)loadMoreButton:(id)sender {
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

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchRecipes)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    

        for(int i =0; i<20; i++){
                NSLog(@"recipes");
            [self fetchRecipes];
            
            }
        
    
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfRecipes.count;
}

- (RecipeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    Recipe *recipe = self.arrayOfRecipes[indexPath.row];
    NSLog(@"%@: Recipes", recipe[@"recipeName"]);
    cell.recipeName.text = recipe[@"recipeName"];
    cell.recipeDescription.text = [[NSAttributedString alloc] initWithData:[recipe[@"recipeInstructions"] dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil].string;

    cell.recipePrice.text = [@"Price: $" stringByAppendingString:recipe[@"recipePrice"]];
    NSString *URLString = recipe[@"recipeImage"];
    NSURL *url = [NSURL URLWithString:URLString];
    [cell.recipePicture setImageWithURL:url];
    return cell;
 
}


- (void) fetchRecipes {
    NSURL *url = [NSURL URLWithString:@"https://api.spoonacular.com/recipes/random?apiKey=10af67ab341f46a8ad2fb587b5922c93"];
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

                   [self.arrayOfRecipes addObject:recipe];
                   NSLog(@"%@", self.arrayOfRecipes);
               }
               else {
                 
                   NSMutableArray *recipes = [Recipe recipesWithArray:dataDictionary[@"recipes"]];
                   self.arrayOfRecipes = recipes;
                   
               }
               
               Recipe *recipeInfo = self.arrayOfRecipes[self.arrayOfRecipes.count - 1];
               PFObject *recipe = [PFObject objectWithClassName:@"Recipe"];
               recipe[@"recipeName"] = recipeInfo.name;
               recipe[@"recipeImage"] = recipeInfo.image;
               recipe[@"recipePrice"] = recipeInfo.price;
//               recipe[@"recipeIDNumber"] = recipeInfo.idnumber;
               [recipe saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                   if (succeeded) {
                       NSLog(@"Recipes been saved 🥶🥶🥶🥶🥶🥶🥶");
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
    recipeDetailVC.recipe = self.arrayOfRecipes[IndexPath.row];
   
}
 /*
- (void)fetchParseData{
        PFQuery *query = [PFQuery queryWithClassName:@"Recipe"];
        [query orderByDescending:@"createdAt"];
        query.limit = 20;
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

*/


@end













