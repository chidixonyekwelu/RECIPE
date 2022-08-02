//
//  LoginViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/6/22.
//

#import "LoginViewController.h"
#import "LocalAuthentication/LocalAuthentication.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usersPassword;
@property (weak, nonatomic) IBOutlet UITextField *usersUsername;
@end

@implementation LoginViewController
- (IBAction)faceIDButton:(id)sender {
    LAContext *laContext = [[LAContext alloc] init];
    
    NSError *error;
    
    if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
    
        if (error != NULL) {
            
        } else {
    
            if (@available(iOS 11.0.1, *)) {
                if (laContext.biometryType == LABiometryTypeFaceID) {
                    NSLog(@"FaceId support");
                } else if (laContext.biometryType == LABiometryTypeTouchID) {
                    NSLog(@"TouchId support");
                } else {
                    NSLog(@"No Biometric support");
                }
            } else {
            }
    
    
            [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"Test Reason" reply:^(BOOL success, NSError * _Nullable error) {
    
                if (error != NULL) {
                }
                else if (success) {
                }
                else {
                }
            }];
        }
    }
}

- (IBAction)signInButton:(id)sender {
    NSString *username = self.usersUsername.text;
    NSString *password = self.usersPassword.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self showHomeTimeline];
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

