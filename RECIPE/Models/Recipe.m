//
//  Recipe.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/11/22.
//

#import "Recipe.h"

@implementation Recipe

@dynamic name;
@dynamic instructions;
@dynamic image;
@dynamic price;
@dynamic country;
@dynamic ingredients;
@dynamic idnumber;

+ (nonnull NSString *)parseClassName {
    return @"Recipe";
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"title"];
        self.instructions = dictionary[@"instructions"];
        self.image = dictionary[@"image"];
        self.price = [NSString stringWithFormat:@"%f", [dictionary[@"pricePerServing"] floatValue] * [dictionary[@"servings"] floatValue] /100];
        self.ingredients = dictionary[@"extendedIngredients"];
        NSLog(@"DICTIONARY: %@", dictionary);
        
        
    }
    return self;
}

+ (NSMutableArray *)recipesWithArray:(NSArray *)dictionaries {
    NSMutableArray *recipes = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Recipe *recipe = [[Recipe alloc] initWithDictionary:dictionary];
        [recipes addObject:recipe];
    }

    return recipes;
}

@end
