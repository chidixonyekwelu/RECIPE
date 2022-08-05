//
//  RegisterViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/7/22.
//

#import "RegisterViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usersWeight;
@property (weak, nonatomic) IBOutlet UITextField *usersAge;
@property (weak, nonatomic) IBOutlet UITextField *usersPassword;
@property (weak, nonatomic) IBOutlet UITextField *usersUsername;

@end

@implementation RegisterViewController
- (IBAction)signUpButton:(id)sender {
    
    PFUser *newUser = [PFUser user];
    
   
    newUser.username = self.usersUsername.text;
    newUser.password = self.usersPassword.text;
    [newUser setValue:_usersAge.text forKey:@"Age"];
    [newUser setValue:_usersWeight.text forKey:@"Weight"];
    
    NSLog(@"My age is: %@ 🤠", self.usersAge);
//    NSLog(@"My weight is: %@" );
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
   }
   }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void) showHomeTimeline {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    SceneDelegate *mySceneDelegate = (SceneDelegate *) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
    mySceneDelegate.window.rootViewController = tabBarController;
}


@end
