//
//  TabBarAnimationViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 8/3/22.
//

#import "TabBarAnimationViewController.h"

@interface TabBarAnimationViewController ()

@end

@implementation TabBarAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeUnselectedColor];
    [self changeHeightOfTabbar];
    [self changeRadiusOfTabBarItem];
    UITabBarItem *item;
    [self simpleAnimationWhenSelectItem:item];
}

- (void) changeRadiusOfTabBarItem {
    self.tabBar.layer.masksToBounds = true;
    self.tabBar.translucent = YES;
    self.tabBar.layer.cornerRadius = 50;
    self.tabBar.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
}

- (void) changeUnselectedColor {
    UIColor *customColor = [[UIColor alloc] initWithRed:0.900 green:0.100 blue:0.100 alpha:1];
    self.tabBar.tintColor = customColor;
}
- (void) changeHeightOfTabbar {
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        CGRect tabFrame = self.tabBar.frame;
        tabFrame.size.height = 300;
        tabFrame.origin.y = self.tabBar.frame.size.height - 100;
        self.tabBar.frame = tabFrame;
    }
}

- (void) simpleAnimationWhenSelectItem:(UITabBarItem *)item {
    
    if([item valueForKey:@"view"]) {
        UIView *uiView = [item valueForKey:@"view"];
        NSTimeInterval timeInterval = 1.0;
        UIViewPropertyAnimator *propertyAnimator = [[UIViewPropertyAnimator alloc]initWithDuration:timeInterval dampingRatio:0.6 animations:^{
            uiView.transform = CGAffineTransformMakeScale(4.9, 4.9);
        }];
        
        CGFloat cgTimeInterval = (CGFloat)timeInterval;
        [propertyAnimator addAnimations:^{ uiView.transform = CGAffineTransformIdentity; } delayFactor: cgTimeInterval];
        [propertyAnimator startAnimation];
        
    }
}
@end
