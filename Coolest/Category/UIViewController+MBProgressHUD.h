//
//  UIViewController+MBProgressHUD.h
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//
//由于HUD经常在UIViewController中使用，可以写个分类添加一些与HUD相关的方法


#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (MBProgressHUD)

-(void)showSuccess:(NSString *)success;
-(void)showError:(NSString *)error;
-(void)showMessage:(NSString *)message;
-(void)showWaiting;
-(void)showLoading;
-(void)showLoadingWithMessage:(NSString *)message;
-(void)hideHUD;

@end
