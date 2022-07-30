//
//  RecipeDetailsViewController.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/7/22.
//

#import "RecipeDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "HomeTimelineViewController.h"

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
    [self fetchRecipeInfoUsingID:self.recipe.idnumber];  
 
}

- (void)fetchRecipeInfoUsingID :(NSString *)idnumber {
        NSString *str = [NSString stringWithFormat:@"https://api.spoonacular.com/recipes/%@/information?includeNutrition=false&apiKey=56ffff1678d042b3aff0288b3be2e049" , idnumber];
        NSURL *url = [NSURL URLWithString:str];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
          if (error != nil) {
              NSLog(@"%@", [error localizedDescription]);
              UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No connection"
                                             message:@"Network Request Failed"
                                             preferredStyle:UIAlertControllerStyleAlert];
               
              UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleDefault
                 handler:^(UIAlertAction * action) {}];
               
              [alert addAction:defaultAction];
              [self presentViewController:alert animated:YES completion:nil];
           }
          else {
              NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
              NSLog(@"DICTIONARY: %@", dataDictionary);
              self.recipeName.text = self.recipe.name;
              self.recipeInstructions.text = [[NSAttributedString alloc] initWithData:[dataDictionary[@"instructions"] dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil].string;
              self.recipePrice.text = [@"Price: $" stringByAppendingString:self.recipe.price];
              NSString *URLString = self.recipe.image;
              NSURL *url = [NSURL URLWithString:URLString];
              [self.recipeImage setImageWithURL:url];
              NSLog(@"RECIPE: %@", self.recipe);
              NSLog(@"INGREDIENTS: %@", dataDictionary[@"extendedIngredients"]);
              
              NSString *ingredientsString = @"Ingredients \n";
              int counter = 1;
              
              for (NSDictionary *dict in dataDictionary[@"extendedIngredients"])
              {
                  ingredientsString = [ingredientsString stringByAppendingString:[NSString stringWithFormat:@"    %i. %@ \n", counter, dict[@"name"]]];
                  counter = counter + 1;
              }
              
              self.recipeIngredients.text = ingredientsString;
          }
              
                   
                  
      
                
              
          }];
       [task resume];
       


}


@end




