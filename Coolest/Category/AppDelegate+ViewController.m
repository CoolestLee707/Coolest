//
//  AppDelegate+ViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "AppDelegate+ViewController.h"
#import "BaseTabBarViewController.h"

@implementation AppDelegate (ViewController)

/**
 *  window实例
 */
- (void)setAppWindows
{
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [self.window makeKeyAndVisible];
    
}

/**
 *  设置根视图
 */
- (void)setRootViewController
{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.rootViewController = [[BaseTabBarViewController alloc]init];
    
}

@end
