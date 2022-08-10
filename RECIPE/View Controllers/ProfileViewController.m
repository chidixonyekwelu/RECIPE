//
//  ProfileViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/7/22.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *profileEmailAddress;
@property (weak, nonatomic) IBOutlet UITextField *profileLastName;
@property (weak, nonatomic) IBOutlet UITextField *profileFirstName;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profileLastName.text = @"Onyekwelu";
    self.profileFirstName.text = @"Chidi";
    self.profileEmailAddress.text = @"chidixonyekwelu@gmail.com";
//    self.profileEmailAddress.text = PFUser.currentUser[@"chidixonyekwelu@gmail.com"];
//    self.profileFirstName = [PFUser.currentUser valueForKey:@"First Name"];
    
    PFUser *newUser = PFUser.currentUser;
    [newUser setValue:self.profileFirstName.text forKey:@"firstName"];
    [newUser setValue:self.profileLastName.text forKey:@"lastName"];
    [newUser setValue:self.profileEmailAddress.text forKey:@"emailAddress"];
    [newUser saveInBackground];

}
    


@end
