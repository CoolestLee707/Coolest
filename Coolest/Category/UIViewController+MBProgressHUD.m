//
//  UIViewController+MBProgressHUD.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "UIViewController+MBProgressHUD.h"

/* 默认加载文字 */
static NSString *const kLoadingMessage = @"正在加载";

/* 默认简短提示语显示的时间 */
static CGFloat const   kShortShowTime  = 1.0f;
static CGFloat const   kLongShowTime  = 2.5f;

static MBProgressHUD * HUD = nil;

@implementation UIViewController (MBProgressHUD)

-(UIView *)getHUDSuperView
{
    return [UIApplication sharedApplication].keyWindow;
    //    UIView *view;
    //    if (self.navigationController.view) {
    //        view=self.navigationController.view;
    //    }else {
    //        view=self.view;
    //    }
    //    return view;
}

- (MBProgressHUD *)getHUD {
    if (!HUD) {
        HUD=[[MBProgressHUD alloc]initWithView:[self getHUDSuperView]];
        HUD.contentColor=[UIColor whiteColor];
        HUD.bezelView.color = [UIColor blackColor];
        HUD.removeFromSuperViewOnHide=YES;
        HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    }
    
    [[self getHUDSuperView] addSubview:HUD];
    [[self getHUDSuperView] bringSubviewToFront:HUD];
    
    return HUD;
}
-(void)showSuccess:(NSString *)success
{
    HUD = [self getHUD];
    HUD.mode=MBProgressHUDModeText;
    HUD.label.text=success;
    HUD.detailsLabel.text=nil;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:kShortShowTime];
}
-(void)showError:(NSString *)error
{
    HUD = [self getHUD];
    HUD.mode=MBProgressHUDModeText;
    HUD.label.text=error;
    HUD.detailsLabel.text=nil;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:kShortShowTime];
}
-(void)showMessage:(NSString *)message
{
    HUD = [self getHUD];
    HUD.mode=MBProgressHUDModeText;
    [HUD showAnimated:YES];
    
    if ([message length] >= 10) {
        HUD.detailsLabel.text = message;
        HUD.label.text=nil;
        [HUD hideAnimated:YES afterDelay:kLongShowTime];
        
    }else {
        HUD.label.text=message;
        HUD.detailsLabel.text=nil;
        [HUD hideAnimated:YES afterDelay:kShortShowTime];
    }
}
-(void)showWaiting
{
    kWeakSelf(weakSelf);
    HUD = [self getHUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.2f];
    HUD.backgroundView.userInteractionEnabled = YES;
    [HUD.backgroundView setTapActionWithBlock:^{
        [weakSelf hideHUD];
    }];
    HUD.label.text=nil;
    HUD.detailsLabel.text=nil;
    [HUD showAnimated:YES];
}
-(void)showLoading
{
    kWeakSelf(weakSelf);
    HUD = [self getHUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.2f];
    HUD.backgroundView.userInteractionEnabled = YES;
    [HUD.backgroundView setTapActionWithBlock:^{
        [weakSelf hideHUD];
    }];
    HUD.label.text=kLoadingMessage;
    HUD.detailsLabel.text=nil;
    [HUD showAnimated:YES];
}
-(void)showLoadingWithMessage:(NSString *)message
{
    kWeakSelf(weakSelf);
    HUD = [self getHUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.2f];
    HUD.backgroundView.userInteractionEnabled = YES;
    [HUD.backgroundView setTapActionWithBlock:^{
        [weakSelf hideHUD];
    }];
    HUD.label.text=message;
    HUD.detailsLabel.text=nil;
    [HUD showAnimated:YES];
}

-(void)hideHUD
{
    [MBProgressHUD hideHUDForView:[self getHUDSuperView] animated:YES];
}

@end
