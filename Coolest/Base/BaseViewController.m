//
//  BaseViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "BaseViewController.h"
#import "UITabBar+badge.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ContentBackColor;
    
    if (!IOS11_OR_LATER) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    NSMutableDictionary *titleAttributes = [NSMutableDictionary dictionary];
    titleAttributes[NSForegroundColorAttributeName] = BaseBlueColor;
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
        barApp.backgroundColor = NavBackColor;
        barApp.titleTextAttributes = titleAttributes;
        self.navigationController.navigationBar.scrollEdgeAppearance = barApp;
        self.navigationController.navigationBar.standardAppearance = barApp;
    }
}

/**
 *  显示没有数据页面
 */
-(void)showNoDataImage
{
    
}

/**
 *  移除无数据页面
 */
-(void)removeNoDataImage
{
    
}

/**
 *  需要登录
 */
- (void)showShouldLoginPoint
{
    
}

/**
 *  加载视图
 */
- (void)showLoadingAnimation
{
    
}

/**
 *  停止加载
 */
- (void)stopLoadingAnimation
{
    
}

/**
 *  分享页面
 *
 *  @param url   url
 *  @param title 标题
 */
- (void)shareUrl:(NSString *)url andTitle:(NSString *)title
{
    
}

- (void)goLogin
{
    
}

/**
 *  状态栏
 */
- (void)initStatusBar
{
    
}

- (void)showStatusBarWithTitle:(NSString *)title
{
    
}

- (void)changeStatusBarTitle:(NSString *)title
{
    
}

- (void)hiddenStatusBar
{
    
}

- (void)createBackButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Nav_back"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(backBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)backBarButtonItemAction
{
    
}

//显示小红点
-(void)newMessageWarning:(int)index msgCount:(int)count {
    [self.tabBarController.tabBar showBadgeOnItemIndex:index msgCount:count];
}


- (void)dealloc {
    ADLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
