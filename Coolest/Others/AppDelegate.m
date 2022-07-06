//
//  AppDelegate.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "AppDelegate.h"
#import "CL_ExceptionHander.h"
#import "CL_AppLaunchTime.h"

@interface AppDelegate ()

@property (nonatomic,strong) CLLocationManager *appleLocationManager;

@end


@implementation AppDelegate

extern CFAbsoluteTime startTime;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    main函数执行后时间
//    ADLog(@"Lanched time %f",(CFAbsoluteTimeGetCurrent() - startTime));
    [CL_AppLaunchTime markTime];
        
    
    
    // 读取应用配置信息，放入上下文
    static NSString *key = @"app_configuration";
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:launchOptions];
    NSDictionary *app_configuration = [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
    if (app_configuration.allKeys.count > 0) {
        [options setObject:app_configuration forKey:key];
    }
    [WBContext shareInstance].application = application;
    [WBContext shareInstance].launchOptions = options;
    
    
//    NSString *selectLanguage = @"en";

//    NSString *selectLanguage = @"zh-Hans";
    
//    ADSetLocalLanguage(selectLanguage);
    
    [self setAppWindows];
    
    [self setRootViewController];
    
    [self systemConfigration];
    
//    [self setTouchService:application Options:launchOptions];
    
//    本地推送
//    [self registerAPN];
    
//    BOOL isPrisonBreak = [self isJailBreak];
//
//    NSString *qqqq = @"没有越狱";
//    if (isPrisonBreak) {
//        qqqq = @"越狱了";
//    }
    
    [CL_ExceptionHander setupExceptionHandler];

//    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:launchOptions];
//    ADLog(@"options - %@",options);
    
 
    [super application:application didFinishLaunchingWithOptions:launchOptions];

    return YES;
}


@end
