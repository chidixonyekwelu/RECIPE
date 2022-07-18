//
//  Recipe.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/11/22.
//

#import "Recipe.h"

@implementation Recipe

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"title"];
        self.instructions = dictionary[@"instructions"];
        self.image = dictionary[@"image"];
    // Initialize any other properties
    }
    return self;
}

// TODO: Modify this to use with Recipes
+ (NSMutableArray *)recipesWithArray:(NSArray *)dictionaries {
// a recipe array
    NSMutableArray *recipes = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        // initialize a Recipe object
        Recipe *recipe = [[Recipe alloc] initWithDictionary:dictionary];
        // add the recipe to the array
        [recipes addObject:recipe];
    }

    return recipes;
}

@end
