//
//  UIApplication+WBExtension.h
//  WBFoundation
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (WBExtension)

/// 应用包名
@property (nonatomic, copy, readonly) NSString *wb_appBundleName;

/// 应用Bundle ID
@property (nonatomic, copy, readonly) NSString *wb_appBundleID;

/// 应用显示版本号
@property (nonatomic, copy, readonly) NSString *wb_appVersion;

/// 应用Build版本号
@property (nonatomic, copy, readonly) NSString *wb_appBuildVersion;


/// 当前窗口
+ (UIWindow *)wb_frontWindow;

/// 重置UIWindos为keyWindow
+ (void)wb_makeKeyWindow;

/// 当前导航
+ (UINavigationController *)wb_navigationController;

/// 当前显示VC
+ (__kindof UIViewController *)wb_currentViewController;
@end

NS_ASSUME_NONNULL_END
