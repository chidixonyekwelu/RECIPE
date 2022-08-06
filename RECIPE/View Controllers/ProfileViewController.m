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
    self.profileLastName.text = PFUser.currentUser[@"Onyekwelu"];
    self.profileFirstName.text = PFUser.currentUser[@"Chidi"];
    self.profileEmailAddress.text = PFUser.currentUser[@"chidixonyekwelu@gmail.com"];
    self.profileFirstName = [PFUser.currentUser valueForKey:@"First Name"];
    PFUser *newUser = [PFUser user];
    [newUser setValue:self.profileFirstName.text forKey:@"First Name"];
    [newUser setValue:self.profileLastName.text forKey:@"Last Name"];
    [PFUser.currentUser saveInBackground];

}
    


@end
