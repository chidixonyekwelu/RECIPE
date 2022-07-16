//
//  RecipeDetailsViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/7/22.
//

#import "RecipeDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface RecipeDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *recipeIngredients;
@property (weak, nonatomic) IBOutlet UILabel *recipeInstructions;
@property (weak, nonatomic) IBOutlet UILabel *recipeName;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;
@property (nonatomic, strong) NSArray *arrayOfIngredients;

@end

@implementation RecipeDetailsViewController {
    BOOL isthere;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recipeName.text = self.arrayOfRecipes[@"title"];
    self.recipeInstructions.text = self.arrayOfRecipes[@"instructions"];
    
    NSString *URLString = _arrayOfRecipes[@"image"];
    NSURL *url = [NSURL URLWithString:URLString];
    [self.recipeImage setImageWithURL:url];
    isthere = true;
    
    int i = 1;
    NSString *indexer;
    NSString *ingredientLabelString = @"    Ingredients:  \n";
    
    while (isthere){
        indexer = [NSString stringWithFormat:@"extendedIngredients%i", i];
        NSString *nextone = [NSString stringWithFormat:@"extendedIngredients%i", i+1];
        NSLog(@"🥶🥶🥶🥶🥶%@",self.arrayOfRecipes[indexer]);
        
       ingredientLabelString = [ingredientLabelString stringByAppendingString:[NSString stringWithFormat:@"    %i. %@ \n", i, self.arrayOfRecipes[indexer]]];
        if ([self.arrayOfRecipes objectForKey:nextone] == nil) {
            isthere = false;
        }
        i++;
    }
    NSLog(@"😡😡😡😡😡😡😡😡%@", ingredientLabelString);
    self.recipeIngredients.text = ingredientLabelString;
    // Do any additional setup after loading the view.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
