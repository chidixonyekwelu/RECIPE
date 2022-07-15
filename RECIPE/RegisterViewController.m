//
//  RegisterViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/7/22.
//

#import "RegisterViewController.h"
#import "Parse/Parse.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usersPassword;
@property (weak, nonatomic) IBOutlet UITextField *usersUsername;

@end

@implementation RegisterViewController
- (IBAction)signUpButton:(id)sender {
    
    PFUser *newUser = [PFUser user];
    
   
    newUser.username = self.usersUsername.text;
    newUser.password = self.usersPassword.text;
    
    
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


@end
