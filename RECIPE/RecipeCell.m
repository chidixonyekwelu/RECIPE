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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
- (void) showData {
    self.recipeName.text = self.recipe.textname;
    self.recipeDescription.text = self.recipe.text;
    NSString *URLString = self.recipe.recipePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.recipePicture.image = [UIImage imageWithData:urlData];
    
*/

@end
