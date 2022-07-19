//
//  RecipeDetailsViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/7/22.
//

#import "RecipeDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface RecipeDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *recipePrice;
@property (weak, nonatomic) IBOutlet UILabel *recipeInstructions;
@property (weak, nonatomic) IBOutlet UILabel *recipeIngredients;
@property (weak, nonatomic) IBOutlet UILabel *recipeName;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;

@end

@implementation RecipeDetailsViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recipeName.text = self.recipe.name;
    self.recipeInstructions.text = self.recipe.instructions;
    self.recipePrice.text = self.recipe.price;
    NSString *URLString = self.recipe.image;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.recipeImage setImageWithURL:url];
    
    NSLog(@"RECIPE: %@", self.recipe);
    NSLog(@"INGREDIENTS: %@", self.recipe.ingredients);
    
    NSString *ingredientsString = @"Ingredients \n";
    int counter = 1;
    
    for (NSDictionary *dict in self.recipe.ingredients){
        ingredientsString = [ingredientsString stringByAppendingString:[NSString stringWithFormat:@"    %i. %@ \n", counter, dict[@"name"]]];
        counter = counter + 1;
    }
    
    self.recipeIngredients.text = ingredientsString;
    
 
}


@end




