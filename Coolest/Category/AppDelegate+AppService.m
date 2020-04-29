//
//  AppDelegate+AppService.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import <UserNotifications/UserNotifications.h>

@implementation AppDelegate (AppService)

- (void)registerAPN {

    if (@available(iOS 10.0, *)) { // iOS10 以上
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
    } else {// iOS8.0 以上
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}

/**
 *  系统配置
 */
- (void)systemConfigration
{
    
}

/**
 *  友盟注册
 */
- (void)registerUmeng{
    
}


/**
 *  检查更新
 */
- (void)checkAppUpDataWithshowOption:(BOOL)showOption
{
    
}

/**
 *  获取用户信息
 */
- (void)getUserData
{
    
}

/**
 设置3D touch
 */
- (void)setTouchService:(UIApplication *)application Options:(NSDictionary *)launchOptions
{
    if (@available(iOS 9.0, *)) {
        
        // 检测3d touch 是否可用
        if (self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            
            //手动创建3D Touch选项
            //系统风格的icon
//                UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove];
//                UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeFavorite];
//                UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeTime];
//                UIApplicationShortcutIcon *icon4 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCaptureVideo];
            
            //自定义图标
            UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"tabbar_icon1_normal"];
            UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"tabbar_icon2_normal"];
            UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"tabbar_icon3_normal"];
            UIApplicationShortcutIcon *icon4 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"tabbar_icon4_normal"];
            
            //创建选项
            UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"com.Coolests.1tab" localizedTitle:@"第一" localizedSubtitle:@"直达1" icon:icon1 userInfo:nil];
            UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"com.Coolests.2tab" localizedTitle:@"第二" localizedSubtitle:@"直达2" icon:icon2 userInfo:nil];
            UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"com.Coolests.3tab" localizedTitle:@"第三" localizedSubtitle:@"直达3" icon:icon3 userInfo:nil];
            UIApplicationShortcutItem *item4 = [[UIApplicationShortcutItem alloc] initWithType:@"com.Coolests.4tab" localizedTitle:@"第四" localizedSubtitle:@"直达4" icon:icon4 userInfo:nil];
            //添加到选项数组
            [UIApplication sharedApplication].shortcutItems = @[item1,item2,item3,item4];
            
            UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
            if (shortcutItem) {
                //判断先前我们设置的快捷选项标签唯一标识，根据不同标识执行不同操作
                if([shortcutItem.type isEqualToString:@"com.Coolests.1tab"]){
                    
                    [self touch_one];
                } else if ([shortcutItem.type isEqualToString:@"com.Coolests.2tab"]) {
                    
                    [self touch_two];
                } else if ([shortcutItem.type isEqualToString:@"com.Coolests.3tab"]) {
                    
                    [self touch_three];
                } else if ([shortcutItem.type isEqualToString:@"com.Coolests.4tab"]) {
                    
                    [self touch_four];
                }
            }
        }
    }
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    //判断先前我们设置的快捷选项标签唯一标识，根据不同标识执行不同操作
    if([shortcutItem.type isEqualToString:@"com.Coolests.1tab"]){
        
        [self touch_one];
    } else if ([shortcutItem.type isEqualToString:@"com.Coolests.2tab"]) {
        
        [self touch_two];
    } else if ([shortcutItem.type isEqualToString:@"com.Coolests.3tab"]) {
        
        [self touch_three];
    } else if ([shortcutItem.type isEqualToString:@"com.Coolests.4tab"]) {
        
        [self touch_four];
    }
    
    if (completionHandler) {
        completionHandler(YES);
    }
}

- (void)touch_one {
    
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    tabBarVC.selectedIndex = 0;
}

- (void)touch_two {
    
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    tabBarVC.selectedIndex = 1;
}
- (void)touch_three {
    
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    tabBarVC.selectedIndex = 2;
}

- (void)touch_four {
    
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    tabBarVC.selectedIndex = 3;
}

- (BOOL)isJailBreak {

//    __block BOOL jailBreak = NO;
//    NSArray *array = @[@"/Applications/Cydia.app",@"/private/var/lib/apt",@"/usr/lib/system/libsystem_kernel.dylib",@"Library/MobileSubstrate/MobileSubstrate.dylib",@"/etc/apt"];
//
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:obj];
//        if ([obj isEqualToString:@"/usr/lib/system/libsystem_kernel.dylib"]) {
//            jailBreak |= !fileExist;
//        }else {
//         jailBreak |= fileExist;
//        }
//    }];
//
//    return jailBreak;
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        return YES;
    }
    return NO;
}
@end
