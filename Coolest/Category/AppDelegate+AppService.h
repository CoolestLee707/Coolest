//
//  AppDelegate+AppService.h
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppService)

/**
 *  系统配置
 */
- (void)systemConfigration;

/**
 *  友盟注册
 */
- (void)registerUmeng;

/**
 *  检查更新
 */
- (void)checkAppUpDataWithshowOption:(BOOL)showOption;

/**
 *  获取用户信息
 */
- (void)getUserData;


/**
 设置3D touch
 */
- (void)setTouchService:(UIApplication *)application Options:(NSDictionary *)launchOptions;


/// 判断是否越狱
- (BOOL)isJailBreak;


- (void)registerAPN;

@end
