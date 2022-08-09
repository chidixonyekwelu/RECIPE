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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchRecipeInfoUsingID:self.recipe.idnumber];
 
}

- (void)fetchRecipeInfoUsingID :(NSString *)idnumber {
        NSString *str = [NSString stringWithFormat:@"https://api.spoonacular.com/recipes/%@/information?includeNutrition=false&apiKey=86a3c720d5e04f2ea73e3b2dd6b22eb3" , idnumber];
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
              self.recommendationRecipeName.text = self.recipe.name;
              self.recommendationRecipeInstructions.text = [[NSAttributedString alloc] initWithData:[dataDictionary[@"instructions"] dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil].string;
              double recipePrice = [self.recipe.price doubleValue];
              NSString* formattedRecipePrice = [NSString stringWithFormat:@"%.02f", recipePrice];
              self.recommendationRecipePrice.text = [@"Price: $" stringByAppendingString:formattedRecipePrice];
              NSString *URLString = self.recipe.image;
              NSURL *url = [NSURL URLWithString:URLString];
              [self.recommendationRecipeImage setImageWithURL:url];
              NSLog(@"RECIPE: %@", self.recipe);
              NSLog(@"INGREDIENTS: %@", dataDictionary[@"extendedIngredients"]);
              
              NSString *ingredientsString = @"Ingredients \n";
              int counter = 1;
              
              for (NSDictionary *dict in dataDictionary[@"extendedIngredients"])
              {
                  ingredientsString = [ingredientsString stringByAppendingString:[NSString stringWithFormat:@"    %i. %@ \n", counter, dict[@"name"]]];
                  counter = counter + 1;
              }
              
              self.recommendationRecipeIngredients.text = ingredientsString;
          }
              
                   
                  
      
                
              
          }];
       [task resume];
       


}






@end
