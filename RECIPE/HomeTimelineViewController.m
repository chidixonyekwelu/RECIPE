//
//  HomeTimelineViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/6/22.
//

#import "HomeTimelineViewController.h"

@interface HomeTimelineViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *arrayOfrecipes;
@property(strong, nonatomic) UIRefreshControl *refreshcontrol;
@end

@implementation HomeTimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchrecipes];
    // Do any additional setup after loading the view.
}

- (void) fetchrecipes {
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
