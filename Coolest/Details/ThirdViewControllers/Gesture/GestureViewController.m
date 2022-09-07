//
//  GestureViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/9/7.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController ()

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手势";
    [self test1];
}

- (void)test1 {
    
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    v1.backgroundColor = UIColor.redColor;
    [self.view addSubview:v1];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 250, 100, 100);
    btn1.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
//    默认YES.阻止事件传递，button上添加手势，只响应手势，设置为NO，button和手势事件都可以响应了
    tap.cancelsTouchesInView = NO;
    [btn1 addGestureRecognizer:tap];
    
    
//    button上添加其他手势不会影响不会影响button响应
    UIPanGestureRecognizer *pang = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan)];
//    [btn1 addGestureRecognizer:pang];
}

- (void)tapClick {
    ADLog(@"tapClick");
}

- (void)pan {
    ADLog(@"pan");
}

- (void)btn1Click {
    ADLog(@"btnClick");
}


@end
