//
//  RecipeObject.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/20/22.
//

#import "RecipeObject.h"

@implementation RecipeObject

@dynamic name;
@dynamic image;
@dynamic price;
@dynamic idnumber;
@dynamic instructions;


+ (nonnull NSString *)parseClassName {
    return @"RecipeObject";
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"title"];
        self.image = dictionary[@"image"];
        self.instructions = dictionary[@"instructions"];
        self.price = [NSString stringWithFormat:@"%f", [dictionary[@"pricePerServing"] floatValue] * [dictionary[@"servings"] floatValue] /100];
        NSLog(@"DICTIONARY: %@", dictionary);
        self.idnumber = [NSString stringWithFormat:@"%@", dictionary[@"id"]];
        
        
    }
    return self;
}

+ (NSMutableArray *)recipesWithArray:(NSArray *)dictionaries {
    NSMutableArray *recipes = [NSMutableArray array];
        for (NSDictionary *dictionary in dictionaries) {
            RecipeObject *recipe = [[RecipeObject alloc] initWithDictionary:dictionary];
            [recipes addObject:recipe];
    }

    return recipes;
}
@end
