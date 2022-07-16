//
//  APIManager.m
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/15/22.
//
/*
#import "APIManager.h"
static NSString * const baseURLString = @"https://api.spoonacular.com/recipes/complexSearch";

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
  NSURL *baseURL = [NSURL URLWithString:baseURLString];

      NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
      NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];

      NSString *key = [dict objectForKey: @"consumer_Key"];
    
    // Check for launch arguments override
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"]) {
        key = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"];
    }
    
    self = [super initWithBaseURL:baseURL consumerKey:key];
    if (self) {
        
    }
    return self;
}

@end

*/
