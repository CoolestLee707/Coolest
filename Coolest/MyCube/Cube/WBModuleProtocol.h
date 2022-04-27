//
//  WBModuleProtocol.h
//  WBCube
//
//  Created by 金修博 on 2018/11/27.
//  Copyright © 2018 金修博. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBContext;

typedef NS_ENUM(NSUInteger, WBModulePriority) {
    WBModulePriorityDefault,
    WBModulePriorityNormal,
    WBModulePriorityHigh,
    WBModulePriorityHighest
};

@protocol WBModuleProtocol <NSObject>

#pragma mark - App生命周期事件
@optional
///App启动
- (void)modDidFinishLaunchingEvent:(WBContext *)context;

///App被挂起
- (void)modWillResignActiveEvent:(WBContext *)context;

///App被挂起后复原
- (void)modDidBecomeActiveEvent:(WBContext *)context;

///App进入后台
- (void)modDidEnterBackgroundEvent:(WBContext *)context;

///App进入前台
- (void)modWillEnterForegroundEvent:(WBContext *)context;

///App终止
- (void)modWillTerminateEvent:(WBContext *)context;

///App收到内存警告
- (void)modDidReceiveMemoryWarningEvent:(WBContext *)context;

#pragma mark - App推送事件
///注册远程推送失败
- (void)modDidFailToRegisterForRemoteNotificationEvent:(WBContext *)context;

///注册远程推送获取deviceToken
- (void)modDidRegisterForRemoteNotificationEvent:(WBContext *)context;

///iOS10以下接收到远程推送消息
- (void)modDidReceiveRemoteNotificationEvent:(WBContext *)context;

///iOS10以下接收到本地推送消息
- (void)modDidReceiveLocalNotificationEvent:(WBContext *)context;

///iOS10以上接收到推送
- (void)modDidReceiveNotificationResponseEvent:(WBContext *)context;

#pragma mark - 快捷事件
- (void)modShortcutActionEvent:(WBContext *)context;

#pragma mark - Apple Watch
- (void)modHandleWatchKitExtensionRequestEvent:(WBContext *)context;

#pragma mark - User Activity
- (void)modDidUpdateUserActivityEvent:(WBContext *)context;

- (void)modDidFailToContinueUserActivityEvent:(WBContext *)context;

- (void)modContinueUserActivityEvent:(WBContext *)context;

- (void)modWillContinueUserActivityEvent:(WBContext *)context;

#pragma mark - 其他系统事件
///模块内自定义处理URL
- (void)modOpenURLEvent:(WBContext *)context;

- (void)modCustomEvent:(WBContext *)context;

- (void)modSystemEvent:(WBContext *)context;

#pragma mark - Module生命周期事件
///优先级,取值范围无上限,值越高优先级越高
- (WBModulePriority)priority;

///安装模块
- (void)modInstallEvent:(WBContext *)context;

///初始化模块
- (void)modInitEvent:(WBContext *)context;

///初始化模块工作异步派发到主队列执行（优先级不高的工作这里可以返回YES）
- (BOOL)async;

///卸载模块
- (void)modUninstallEvent:(WBContext *)context;

#pragma mark - User生命周期事件
///用户登录成功
- (void)modUserLoginSuccessEvent:(WBContext *)context;

///用户登录失败
- (void)modUserLoginFailEvent:(WBContext *)context;

/// 用户即将退出登录
- (void)modUserWillLogoutEvent:(WBContext *)context;

///用户退出成功
- (void)modUserLogoutSuccessEvent:(WBContext *)context;

///用户退出失败
- (void)modUserLogoutFailEvent:(WBContext *)context;

///用户异常登出
- (void)modUserAbnormalSignoutEvent:(WBContext *)context;

///用户活跃状态
- (void)modUserActiveEvent:(WBContext *)context;

///用户删除用户数据
- (void)modUserDeleteAccountDataEvent:(WBContext *)context;

///用户注销
- (void)modUserOffAccountEvent:(WBContext *)context;


#pragma mark - 首页生命周期事件
//ViewWillAppear
- (void)modHomePageWillAppearEvent:(WBContext *)context;

//ViewDidAppear
- (void)modHomePageDidAppearEvent:(WBContext *)context;

//ViewDidLoad
- (void)modHomePageViewDidLoadEvent:(WBContext *)context;

#pragma mark - tab点击事件
- (void)modTabbarItemClickEvent:(WBContext *)context;

@end
