//
//  LoginViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/6/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usersPassword;
@property (weak, nonatomic) IBOutlet UITextField *usersUsername;
@end

@implementation LoginViewController
- (IBAction)signInButton:(id)sender {
    NSString *username = self.usersUsername.text;
    NSString *password = self.usersPassword.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self showHomeTimeline];
        }}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) showHomeTimeline {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"HomeTimelineViewController"];
    SceneDelegate *mySceneDelegate = (SceneDelegate *) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
        mySceneDelegate.window.rootViewController = tabBarController;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

/*
 login
 NSString *username = self.usersUsername.text;
 NSString *password = self.usersPassword.text;
 
 [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
     if (error != nil) {
         NSLog(@"User log in failed: %@", error.localizedDescription);
     } else {
         NSLog(@"User logged in successfully");
         [self showHomeTimeline];
     }}];
 */

/*
 
 sign up
 // initialize a user object
 PFUser *newUser = [PFUser user];
 
 // set user properties
 newUser.username = self.usersUsername.text;
 newUser.password = self.usersPassword.text;
 
 // call sign up function on the object
 [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
     if (error != nil) {
         NSLog(@"Error: %@", error.localizedDescription);
     } else {
         NSLog(@"User registered successfully");
}
}];
 */
