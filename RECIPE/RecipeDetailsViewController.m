//
//  RecipeDetailsViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/7/22.
//

#import "RecipeDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface RecipeDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *recipedescription;
@property (weak, nonatomic) IBOutlet UILabel *recipename;
@property (weak, nonatomic) IBOutlet UIImageView *recipeimage;

@end

@implementation RecipeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recipename.text = self.arrayOfRecipes[@"strMeal"];
    self.recipedescription.text = self.arrayOfRecipes[@"strInstructions"];
    NSString *URLString = _arrayOfRecipes[@"strMealThumb"];
    NSURL *url = [NSURL URLWithString:URLString];
    [self.recipeimage setImageWithURL:url];
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
