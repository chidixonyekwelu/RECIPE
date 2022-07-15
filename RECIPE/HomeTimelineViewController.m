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

@interface HomeTimelineViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayOfRecipes;
@property(strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation HomeTimelineViewController
- (IBAction)logOutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nilUIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"viewController"];
        SceneDelegate *mySceneDelegate = (SceneDelegate *) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
        mySceneDelegate.window.rootViewController = controller;
        NSLog(@"User logged out");
    }];
    }
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    int i;
    for (i = 0; i < 10;i++){
        NSLog(@"meals");
        [self fetchRecipes];
    }
    //[self fetchPrices];
    [self.tableView reloadData];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchRecipes)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    // Do any additional setup after loading the view.
    
    // API call to fetch the categories
  //  [self fetchCategories];
    // Save this info
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfRecipes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell" forIndexPath:indexPath];
    NSDictionary *recipe = self.arrayOfRecipes[indexPath.row];
    cell.recipeName.text = recipe[@"strMeal"];
    cell.recipeDescription.text = recipe[@"strInstructions"];
    NSString *URLString = recipe[@"strMealThumb"];
    NSURL *url = [NSURL URLWithString:URLString];
    [cell.recipePicture setImageWithURL:url];
    return cell;
 
}


- (void) fetchRecipes {
    NSURL *url = [NSURL URLWithString:@"https://www.themealdb.com/api/json/v1/1/random.php"];
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
               if (self.arrayOfRecipes!= nil){ [self.arrayOfRecipes addObject:dataDictionary[@"meals"][0]];
                   NSLog(@"%@", self.arrayOfRecipes);
               }
               else {
                   self.arrayOfRecipes = dataDictionary[@"meals"];               }
               NSLog(@"%@", self.arrayOfRecipes);
           }
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
       }];
    
    [task resume];
}

- (void) fetchPrices {
    
    NSURL *url = [NSURL URLWithString:@"eyJhbGciOiJSUzI1NiIsImprdSI6Imh0dHBzOi8vYXBpLmtyb2dlci5jb20vdjEvLndlbGwta25vd24vandrcy5qc29uIiwia2lkIjoiWjRGZDNtc2tJSDg4aXJ0N0xCNWM2Zz09IiwidHlwIjoiSldUIn0.eyJhdWQiOiJjaGlkaS1mMmE5ZDdjOWJkNGEwOGUzMzk1ZGU2YWZmYmFjYWRlMzUzNjcyNzcyMjk3NDQ2MzU3NDIiLCJleHAiOjE2NTc4MTgwNTMsImlhdCI6MTY1NzgxNjI0OCwiaXNzIjoiYXBpLmtyb2dlci5jb20iLCJzdWIiOiJhNDMyMDIzMy0wYTk3LTVkOWUtYjA5Ni05MTc2MDZhYThkZGIiLCJzY29wZSI6IiIsImF1dGhBdCI6MTY1NzgxNjI1MzQ2MTE2OTE5OCwiYXpwIjoiY2hpZGktZjJhOWQ3YzliZDRhMDhlMzM5NWRlNmFmZmJhY2FkZTM1MzY3Mjc3MjI5NzQ0NjM1NzQyIn0.BqRZJ1LnIBqaor4tfRbqxZ8Ya5OtNiWgrNneE6b8oXHgBd0JBPRWrXBNwySDc71vlwpYUgcoAXywkLW5rrnPOMexkaU-MtgNcGMJUEcregie83xy93G-JXhBbHkUWv__oz50Ik5XP6fpaiZretnIy00bHUscjlMrS11R8ixP6iToO_e7gVDKeX9Oo3xgrn1FC9QggvmYJSJQcpbYXyR52dIr4bg9qSClLYETX4rvu3KGev12hf4Q-5x11Zk-bWk0QvFDnxG3hgdkQ_VVMmaUCQPAPd-S1WaEYq-_ItWLzqzzZ0SZijlMQAVsLBTwdQ0EMKhkk9WNWmnXAk90newpyw"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        }
    }];
    [task resume];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using
    UITableViewCell *MyCell = sender;
    NSIndexPath *IndexPath = [self.tableView indexPathForCell:MyCell];
    RecipeDetailsViewController *RecipeDetailVC = [segue destinationViewController];
    // TODO: pass along the category info too
    RecipeDetailVC.arrayOfRecipes = self.arrayOfRecipes[IndexPath.row];
   
}



@end
/*
self.tableView.delegate = self;
self.tableView.dataSource = self;
[self.tableView reloadData];
self.tableView.rowHeight = UITableViewAutomaticDimension;
*/
















// Set a property for the category
 
//     Pass the selected object to the new view controller.
// if check for the category
// if strCatgeory = str

// If the meal cateory str is equal to the category string
// Categories are in an array, so you'll have to loop through to find it
// pass this info to the next screen
// else - don't show description
