//
//  AppDelegate.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "AppDelegate.h"
#import "CLKeepAlive.h"
#import "CL_ExceptionHander.h"

@interface AppDelegate ()


@property (nonatomic,strong) CLLocationManager *appleLocationManager;

@end


@implementation AppDelegate

extern CFAbsoluteTime startTime;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    main函数执行后时间
    ADLog(@"Lanched time %f",(CFAbsoluteTimeGetCurrent() - startTime));
        
    
//    [NSThread sleepForTimeInterval:0.2];
    
        
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
//
//    ADLog(@"%@",qqqq);
    
    
//    [CLKeepAlive startLocation];

    [CL_ExceptionHander setupExceptionHandler];

//    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:launchOptions];
//    ADLog(@"options - %@",options);
    
    [[WBModuleManager shareInstance] triggerEvent:kModInstallEvent];
    [[WBModuleManager shareInstance] triggerEvent:kModInitEvent];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [super applicationWillResignActive:application];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    ADLog(@"进入后台");
        
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
//    [[PasswordInputWindow shareInstance]show];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
