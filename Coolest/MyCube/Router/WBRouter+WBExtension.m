//
//  WBRouter+WBExtension.m
//  WBCube
//
//  Created by 刘震 on 2020/11/13.
//

#import "WBRouter+WBExtension.h"

@implementation WBRouter (WBExtension)

+ (NSArray *)getServiveAndAction:(SEL)cmd {
    NSString *selectorName = NSStringFromSelector(cmd);
    NSString *name = [selectorName componentsSeparatedByString:@":"].firstObject;
    return [name componentsSeparatedByString:@"_"];
}

+ (UIViewController *)currentViewController {
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (viewController) {
        if ([viewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tbvc = (UITabBarController*)viewController;
            viewController = tbvc.selectedViewController;
        } else if ([viewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nvc = (UINavigationController*)viewController;
            viewController = nvc.topViewController;
        } else if (viewController.presentedViewController) {
            viewController = viewController.presentedViewController;
        } else if ([viewController isKindOfClass:[UISplitViewController class]] &&
                   ((UISplitViewController *)viewController).viewControllers.count > 0) {
            UISplitViewController *svc = (UISplitViewController *)viewController;
            viewController = svc.viewControllers.lastObject;
        } else  {
            return viewController;
        }
    }

    return viewController;
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *currentViewController = [self currentViewController];
    [currentViewController.navigationController pushViewController:viewController animated:animated];
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    UIViewController *currentViewController = [self currentViewController];
    [currentViewController presentViewController:viewControllerToPresent animated:animated completion:completion];
}


@end
