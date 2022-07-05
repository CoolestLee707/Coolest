//
//  UIApplication+WBExtension.m
//  WBFoundation
//
//

#import "UIApplication+WBExtension.h"
#import <sys/utsname.h>

@implementation UIApplication (WBExtension)

- (NSString *)wb_appBundleName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

- (NSString *)wb_appBundleID {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

- (NSString *)wb_appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)wb_appBuildVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}


+ (UIWindow *)wb_frontWindow {
    __block UIWindow *fwindow;
#if !defined(SV_APP_EXTENSIONS)
    void(^block)(void) = ^(){
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows) {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= UIWindowLevelNormal);
            if(windowOnMainScreen && windowIsVisible && windowLevelSupported) {
                fwindow = window;
            }
        }
    };
    if (NSThread.isMainThread) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            block();
        });
    }
#endif
    return fwindow;
}

+ (void)wb_makeKeyWindow {
    UIWindow *window = self.wb_frontWindow;
    [window makeKeyAndVisible];
}

+ (UINavigationController *)wb_navigationController {
    UINavigationController *nav;
    UIViewController *rootVC = self.wb_frontWindow.rootViewController;
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)rootVC;
    } else if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabvc = (UITabBarController *)rootVC;
        nav = tabvc.selectedViewController;
    }else {
        nav = [rootVC navigationController];
    }
    return nav;
}

+ (__kindof UIViewController *)wb_currentViewController {
    UIViewController *viewController = self.wb_frontWindow.rootViewController;
    return [self wb_findViewController:viewController];
}

+ (UIViewController *)wb_findViewController:(UIViewController *)viewController {
    if (viewController.presentedViewController) {
        return [self wb_findViewController:viewController.presentedViewController];
    } else if ([viewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *vc = (UISplitViewController *)viewController;
        if (vc.viewControllers.count > 0) {
            return [self wb_findViewController:vc.viewControllers.lastObject];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *vc = (UINavigationController *)viewController;
        if (vc.viewControllers.count > 0) {
            return [self wb_findViewController:vc.topViewController];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *vc = (UITabBarController *)viewController;
        if (vc.viewControllers.count > 0) {
            return [self wb_findViewController:vc.selectedViewController];
        } else {
            return viewController;
        }
    } else {
        return viewController;
    }
}


@end
