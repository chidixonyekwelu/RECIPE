//
//  RecipeObject.h
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/20/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecipeObject : PFObject <PFSubclassing>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *idnumber;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)recipesWithArray:(NSArray *)dictionaries;
@end

NS_ASSUME_NONNULL_END
