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

@interface HomeTimelineViewController () <UITableViewDataSource>
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
    [self fetchRecipes];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfRecipes.count;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Recipe" forIndexPath:indexPath];
    Recipe *recipe = self.arrayOfRecipes[indexPath.row];
    cell.recipeName.text =
    cell.recipeDescription.text
}
*/

- (void) fetchRecipes {
    NSURL *url = [NSURL URLWithString:@"https://www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

               NSLog(@"%@", dataDictionary);
           }
       }];
    [task resume];
}



@end
/*
self.tableView.delegate = self;
self.tableView.dataSource = self;
[self.tableView reloadData];
self.tableView.rowHeight = UITableViewAutomaticDimension;
*/
