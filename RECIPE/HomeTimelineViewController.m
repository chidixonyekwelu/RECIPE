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
//    int i;
//    for (i = 0; i < 10;i++){
        NSLog(@"recipes");
        [self fetchRecipes];
//    }

    self.tableView.delegate =self;
    [self.tableView reloadData];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchRecipes)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfRecipes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    NSDictionary *recipe = self.arrayOfRecipes[indexPath.row];
    cell.recipeName.text = recipe[@"title"];
    cell.recipeDescription.text = recipe[@"instructions"];
    NSString *URLString = recipe[@"image"];
    NSURL *url = [NSURL URLWithString:URLString];
    [cell.recipePicture setImageWithURL:url];
    return cell;
 
}


- (void) fetchRecipes {
    NSURL *url = [NSURL URLWithString:@"https://api.spoonacular.com/recipes/random?apiKey=7ee2f3490cba48248134eb847d9ec717"];
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
               [self.activityIndicator stopAnimating];
               if (self.arrayOfRecipes!= nil)
               { [self.arrayOfRecipes addObject:dataDictionary[@"recipes"][0]];
                   NSLog(@"%@", self.arrayOfRecipes);
               }
               else {
                   self.arrayOfRecipes = dataDictionary[@"recipes"];               }
               NSLog(@"%@", self.arrayOfRecipes);
           }
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
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













