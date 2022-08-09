//
//  RecommendationDetailsViewController.h
//  RECIPE
//
//  Created by Chidi Onyekwelu on 8/4/22.
//

#import <UIKit/UIKit.h>
#import "RecipeObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendationDetailsViewController : UIViewController
@property (nonatomic, strong) NSDictionary *arrayOfRecipes;
@property (nonatomic, strong) RecipeObject *recipe;

@end

NS_ASSUME_NONNULL_END
