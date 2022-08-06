//
//  RecipeCell.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/7/22.
//

#import "RecipeCell.h"
#import "SceneDelegate.h"

@implementation RecipeCell


- (void)awakeFromNib {
    [super awakeFromNib];

}



- (IBAction)didTapFavorite:(id)sender {
    
    [self.recipeLikeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
}


@end
