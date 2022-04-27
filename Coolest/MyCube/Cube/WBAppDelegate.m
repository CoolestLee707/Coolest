//
//  WBAppDelegate.m
//  WBCube
//
//  Created by 金修博 on 2018/11/28.
//  Copyright © 2018 金修博. All rights reserved.
//

#import "WBAppDelegate.h"
#import "WBCubeHeader.h"
#import "WBTimeProfiler.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
@interface WBAppDelegate ()<UNUserNotificationCenterDelegate>
#else
@interface WBAppDelegate ()
#endif

@end


@implementation WBAppDelegate

@synthesize window;

#pragma mark - Life Cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[WBTimeProfiler sharedTimeProfiler] recordEventTime:@"WBCuber::super start launch"];

    [[WBModuleManager shareInstance] triggerEvent:kModInstallEvent];
    [[WBModuleManager shareInstance] triggerEvent:kModInitEvent];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
#endif
#ifdef DEBUG
    [[WBTimeProfiler sharedTimeProfiler] saveTimeProfileDataIntoFile:@"WBTimeProfiler"];
#endif
    [[WBTimeProfiler sharedTimeProfiler]printOutTimeProfileResult];
    //return [super application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[WBModuleManager shareInstance] triggerEvent:kModWillResignActiveEvent];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[WBModuleManager shareInstance] triggerEvent:kModDidBecomeActiveEvent];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[WBModuleManager shareInstance] triggerEvent:kModWillEnterForegroundEvent];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[WBModuleManager shareInstance] triggerEvent:kModDidEnterBackgroundEvent];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[WBModuleManager shareInstance] triggerEvent:kModWillTerminateEvent];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[WBModuleManager shareInstance] triggerEvent:kModDidReceiveMemoryWarningEvent];
}

#pragma mark - Push Notification
//注册推送失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[WBCube shareInstance].context.notificationItem setReigsterError:error];
    [[WBModuleManager shareInstance] triggerEvent:kModDidFailToRegisterForRemoteNotificationEvent];
}

//注册推送获取deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[WBCube shareInstance].context.notificationItem setDeviceToken:deviceToken];
    [[WBModuleManager shareInstance] triggerEvent:kModDidRegisterForRemoteNotificationEvent];
}

//iOS10以下远程推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[WBCube shareInstance].context.notificationItem setUserInfo:userInfo];
    [[WBModuleManager shareInstance] triggerEvent:kModDidReceiveRemoteNotificationEvent];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[WBCube shareInstance].context.notificationItem setUserInfo:userInfo];
    [[WBCube shareInstance].context.notificationItem setFetchCompletionHandler:completionHandler];
    [[WBModuleManager shareInstance] triggerEvent:kModDidReceiveRemoteNotificationEvent];
}

//iOS10以下本地推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [[WBCube shareInstance].context.notificationItem setLocalNotification:notification];
    [[WBModuleManager shareInstance] triggerEvent:kModDidReceiveLocalNotificationEvent];
}

//iOS10以上推送
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    [[WBCube shareInstance].context.notificationItem setCenter:center];
    [[WBCube shareInstance].context.notificationItem setNotificationResponse:response];
    [[WBCube shareInstance].context.notificationItem setNotificationCompletionHandler:completionHandler];
    [[WBModuleManager shareInstance] triggerEvent:kModDidReceiveNotificationResponseEvent];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
#pragma mark - Open URL
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[WBCube shareInstance].context.openUrlItem setOpenURL:url];
    [[WBModuleManager shareInstance] triggerEvent:kModOpenURLEvent];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    [[WBCube shareInstance].context.openUrlItem setOpenURL:url];
    [[WBCube shareInstance].context.openUrlItem setOptions:options];
    [[WBModuleManager shareInstance] triggerEvent:kModOpenURLEvent];
    return YES;
}

#pragma mark - Shortcut Action
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80400
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler API_AVAILABLE(ios(9.0)) {
    [[WBCube shareInstance].context.shortcutItem setShortcutItem:shortcutItem];
    [[WBCube shareInstance].context.shortcutItem setScompletionHandler:completionHandler];
    [[WBModuleManager shareInstance] triggerEvent:kModShortcutActionEvent];
}
#endif

#pragma mark - User Activity
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        [[WBCube shareInstance].context.userActivityItem setUserActivity:userActivity];
        [[WBModuleManager shareInstance] triggerEvent:kModDidUpdateUserActivityEvent];
    }
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        [[WBCube shareInstance].context.userActivityItem setUserActivityType:userActivityType];
        [[WBCube shareInstance].context.userActivityItem setUserActivityError:error];
        [[WBModuleManager shareInstance] triggerEvent:kModDidFailToContinueUserActivityEvent];
    }
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        [[WBCube shareInstance].context.userActivityItem setUserActivity:userActivity];
        [[WBCube shareInstance].context.userActivityItem setRestorationHandler:restorationHandler];
        [[WBModuleManager shareInstance] triggerEvent:kModContinueUserActivityEvent];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType {
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        [[WBCube shareInstance].context.userActivityItem setUserActivityType:userActivityType];
        [[WBModuleManager shareInstance] triggerEvent:kModWillContinueUserActivityEvent];
    }
    return YES;
}
- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(nullable NSDictionary *)userInfo reply:(void(^)(NSDictionary * __nullable replyInfo))reply {
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        [[WBCube shareInstance].context.watchItem setUserInfo:userInfo];
        [[WBCube shareInstance].context.watchItem setReplyHandler:reply];
        [[WBModuleManager shareInstance] triggerEvent:kModHandleWatchKitExtensionRequestEvent];
    }
}
#endif

@end
