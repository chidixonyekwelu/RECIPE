//
//  RecipeDetailsViewController.h
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/7/22.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecipeDetailsViewController : UIViewController
@property (nonatomic, strong) Recipe *recipe;
@end

NS_ASSUME_NONNULL_END
