//
//  SceneDelegate.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/6/22.
//

#import "SceneDelegate.h"
#import "Parse/Parse.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    if (PFUser.currentUser) {
           UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
           
           self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
       }
    
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
   
}


- (void)sceneWillResignActive:(UIScene *)scene {
    
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    
}


@end
