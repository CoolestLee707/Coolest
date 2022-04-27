//
//  WBContext.h
//  WBCube
//
//  Created by 金修博 on 2018/11/28.
//  Copyright © 2018 金修博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif
@class WBOpenUrlItem;
@class WBNotificationItem;
@class WBShortcutItem;
@class WBUserActivityItem;
@class WBWatchItem;

typedef NS_ENUM(NSUInteger, WBEnvironmentType) {
    WBEnvironmentTypeDev,       // 开发
    WBEnvironmentTypeTest,      // 测试
    WBEnvironmentTypeSandbox,   // 沙箱
    WBEnvironmentTypeProd       // 线上
};

@interface WBContext : NSObject

/// 环境
@property(nonatomic, assign) WBEnvironmentType env;
/// 应用启动时的application
@property(nonatomic, strong) UIApplication *application;
/// 应用启动时的launchOptions
@property(nonatomic, strong) NSDictionary *launchOptions;
/// 自定义事件名称
@property(nonatomic, assign) NSString *customEvent;
/// 跟随事件传递的参数
@property(nonatomic, assign) NSDictionary *customParam;
/// openURL事件的参数
@property(nonatomic, strong) WBOpenUrlItem *openUrlItem;
/// 通知事件的参数
@property(nonatomic, strong) WBNotificationItem *notificationItem;
/// 3D-Touch参数
@property(nonatomic, strong) WBShortcutItem *shortcutItem;
/// 用户活动参数
@property(nonatomic, strong) WBUserActivityItem *userActivityItem;
/// 手表参数
@property(nonatomic, strong) WBWatchItem *watchItem;

#pragma mark - 访问入口
+ (instancetype)shareInstance;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

#pragma mark - 添加模块的服务

/**
 添加模块服务

 @param instance 模块对应的控制器
 @param serviceName 唯一标识符，建议使用模块名称
 */
- (void)addModuleServiceInstance:(id)instance serviceName:(NSString *)serviceName;

- (id)getModuleServiceInstanceWithServiceName:(NSString *)serviceName;

- (void)removeModuleServiceInstanceWithServiceName:(NSString *)serviceName;

@end


#pragma mark - WBOpenUrlItem
@interface WBOpenUrlItem : NSObject
@property(nonatomic, strong) NSURL *openURL;
@property(nonatomic, copy) NSDictionary *options;
@end

#pragma mark - WBNotificationItem
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
typedef void(^WBNotificationCompletionHandler)(void);
#endif
typedef void(^WBFetchCompletionHandler)(UIBackgroundFetchResult);

@interface WBNotificationItem : NSObject
@property (nonatomic, strong) NSData *deviceToken;
@property (nonatomic, strong) NSError *reigsterError;
@property (nonatomic, strong) UILocalNotification *localNotification;
@property (nonatomic, strong) NSDictionary *userInfo;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
@property (nonatomic, strong) UNUserNotificationCenter *center API_AVAILABLE(ios(10.0));
@property (nonatomic, strong) UNNotificationResponse *notificationResponse API_AVAILABLE(ios(10.0));
@property (nonatomic, copy) WBNotificationCompletionHandler notificationCompletionHandler API_AVAILABLE(ios(10.0));
@property (nonatomic, copy) WBFetchCompletionHandler fetchCompletionHandler API_AVAILABLE(ios(10.0));
#endif
@end

#pragma mark - Shortcut Item

typedef void (^WBShortcutCompletionHandler)(BOOL);

@interface WBShortcutItem : NSObject

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400
@property(nonatomic, strong) UIApplicationShortcutItem *shortcutItem API_AVAILABLE(ios(9.0));
@property(nonatomic, copy) WBShortcutCompletionHandler scompletionHandler API_AVAILABLE(ios(9.0));
#endif

@end

#pragma mark - User Activity
typedef void (^WBUserActivityRestorationHandler)(NSArray *);

@interface WBUserActivityItem : NSObject

@property (nonatomic, copy) NSString *userActivityType;
@property (nonatomic, strong) NSUserActivity *userActivity;
@property (nonatomic, strong) NSError *userActivityError;
@property (nonatomic, copy) WBUserActivityRestorationHandler restorationHandler;

@end

#pragma mark - Watch Item
typedef void (^WBWatchReplyHandler)(NSDictionary *replyInfo);

@interface WBWatchItem : NSObject

@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, copy) WBWatchReplyHandler replyHandler;

@end
