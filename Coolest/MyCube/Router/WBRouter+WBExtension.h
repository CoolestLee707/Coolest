//
//  WBRouter+WBExtension.h
//  WBCube
//
//  Created by 刘震 on 2020/11/13.
//

#import "WBRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBRouter (WBExtension)

+ (NSArray *)getServiveAndAction:(SEL)cmd;

+ (UIViewController *)currentViewController;

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
