//
//  RecipeCell.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/7/22.
//

#import "RecipeCell.h"

@implementation RecipeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)didTapFavorite:(id)sender {
//    if(self.recipe.favorited) {
//        [self.likeRecipe setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
//    }
//    // If it's hasn't been favorited, we want to favorite (red icon)
//    else{
//        // Update state (models)
//        self.recipe.favorited = YES;
//        self.recipe.favoriteCount += 1;
//
//        // Update UI
//        [self.likeRecipe setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
//
//        [[APIManager shared] favorite:self.recipe completion:^(Tweet *tweet, NSError *error) {
//            if (error) {
//                NSLog(@"There was an error favoriting the recipe:%@", recipe);
//            } else {
//                NSLog(@"Successfully favorited recipe! %@", recipe);
//            }
//        }];
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


@end
