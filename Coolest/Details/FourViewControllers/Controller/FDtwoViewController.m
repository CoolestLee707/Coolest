//
//  FDtwoViewController.m
//  Coolest
//
//  Created by daoj on 2019/5/8.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "FDtwoViewController.h"

@interface FDtwoViewController ()

@end

@implementation FDtwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"push的";
    self.fd_prefersNavigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor redColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Nav_back"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 45, 45);
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(backBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    // 隐藏tabbar
    self.hidesBottomBarWhenPushed = YES;
}

- (void)backBarButtonItemAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
