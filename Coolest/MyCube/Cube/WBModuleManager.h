//
//  WBModuleManager.h
//  WBCube
//
//  Created by 金修博 on 2018/11/27.
//  Copyright © 2018 金修博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol WBModuleProtocol;

extern NSString * const kModDidFinishLaunchingEvent;
extern NSString * const kModWillResignActiveEvent;
extern NSString * const kModDidBecomeActiveEvent;
extern NSString * const kModWillEnterForegroundEvent;
extern NSString * const kModDidEnterBackgroundEvent;
extern NSString * const kModWillTerminateEvent;
extern NSString * const kModDidReceiveMemoryWarningEvent;
extern NSString * const kModDidRegisterForRemoteNotificationEvent;
extern NSString * const kModDidFailToRegisterForRemoteNotificationEvent;
extern NSString * const kModDidReceiveRemoteNotificationEvent;
extern NSString * const kModDidReceiveNotificationResponseEvent;
extern NSString * const kModDidReceiveLocalNotificationEvent;
extern NSString * const kModCustomEvent;
extern NSString * const kModSystemEvent;
extern NSString * const kModOpenURLEvent;
extern NSString * const kModInstallEvent;
extern NSString * const kModInitEvent;
extern NSString * const kModUninstallEvent;
extern NSString * const kModUserLoginSuccessEvent;
extern NSString * const kModUserLoginFailEvent;
extern NSString * const kModUserWillLogoutEvent;
extern NSString * const kModUserLogoutSuccessEvent;
extern NSString * const kModUserLogoutFailEvent;
extern NSString * const kModUserDeleteAccountDataEvent;
extern NSString * const kModUserOffAccountEvent;
extern NSString * const kModUserAbnormalSignoutEvent;
extern NSString * const kModUserActiveEvent;
extern NSString * const kModShortcutActionEvent;
extern NSString * const kModDidUpdateUserActivityEvent;
extern NSString * const kModDidFailToContinueUserActivityEvent;
extern NSString * const kModContinueUserActivityEvent;
extern NSString * const kModWillContinueUserActivityEvent;
extern NSString * const kModHandleWatchKitExtensionRequestEvent;
extern NSString * const kModHomePageWillAppearEvent;
extern NSString * const kModHomePageDidAppearEvent;
extern NSString * const kModHomePageViewDidLoadEvent;
extern NSString * const kModTabbarItemClickEvent;

@interface WBModuleManager : NSObject

+ (instancetype)shareInstance;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

///注册模块
- (void)registerModule:(Class)moduleClass;

///注销模块
- (void)unregisterModuleWithModule:(Class)moduleClass;

///给模块实例对象注册自定义事件,注册代码可写在模块的install事件中
- (void)registerCustomEvent:(NSString *)event withModuleInstance:(id <WBModuleProtocol>)moduleInstance;

///触发事件
- (void)triggerEvent:(NSString *)eventType;

///触发事件(携带自定义参数)
- (void)triggerEvent:(NSString *)eventType customParam:(NSDictionary *)customParam;

@end
