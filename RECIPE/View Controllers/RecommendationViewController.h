//
//  RecommendationViewController.h
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendationViewController : UIViewController
//@property (nonatomic, strong) Recipe *recipe;

- (instancetype)initWithStartDate:(NSDate *)startDate
                          endDate:(NSDate *)endDate;

@end


NS_ASSUME_NONNULL_END
