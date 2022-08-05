//
//  RecommendationDetailsViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 8/4/22.
//

#import "RecommendationDetailsViewController.h"
#import "RecommendationViewController.h"
#import "UIImageView+AFNetworking.h"

@interface RecommendationDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *recommendationRecipeImage;
@property (weak, nonatomic) IBOutlet UILabel *recommendationRecipeIngredients;
@property (weak, nonatomic) IBOutlet UILabel *recommendationRecipePrice;
@property (weak, nonatomic) IBOutlet UILabel *recommendationRecipeInstructions;
@property (weak, nonatomic) IBOutlet UILabel *recommendationRecipeName;

@end

@implementation RecommendationDetailsViewController 
{
   BOOL isthere;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recommendationRecipeName.text = self.arrayOfRecipes[@"title"];
    self.recommendationRecipeInstructions.text = self.arrayOfRecipes[@"instructions"];
    
    NSString *URLString = _arrayOfRecipes[@"image"];
    NSURL *url = [NSURL URLWithString:URLString];
    [self.recommendationRecipeImage setImageWithURL:url];
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
    self.recommendationRecipeIngredients.text = ingredientLabelString;
}



@end
