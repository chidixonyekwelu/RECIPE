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

}
- (IBAction)didTapFavorite:(id)sender {
    if(self.recipe)
    [self.recipeLikeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
}

//    else{
//    [self.likeTweet setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];



@end
