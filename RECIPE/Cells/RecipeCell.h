//
//  RecipeCell.h
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/7/22.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "RecipeObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecipeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *recommendationRecipePrice;
@property (weak, nonatomic) IBOutlet UIImageView *recommendationRecipeImage;
@property (weak, nonatomic) IBOutlet UILabel *recommendationRecipeName;

@property (weak, nonatomic) IBOutlet UILabel *recipePrice;
@property (weak, nonatomic) IBOutlet UIImageView *recipePicture;
@property (weak, nonatomic) IBOutlet UILabel *recipeDescription;
@property (weak, nonatomic) IBOutlet UILabel *recipeName;
@property (weak, nonatomic) IBOutlet UIButton *recipeLikeButton;

@property (nonatomic, strong) RecipeObject *recipe;

@end

NS_ASSUME_NONNULL_END
