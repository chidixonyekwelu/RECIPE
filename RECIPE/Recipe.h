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
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *ingredients;
@end

NS_ASSUME_NONNULL_END
