//
//  Recipe.h
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Recipe : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *instructions;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *idnumber;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSArray *ingredients;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)recipesWithArray:(NSArray *)dictionaries;
@end

NS_ASSUME_NONNULL_END
