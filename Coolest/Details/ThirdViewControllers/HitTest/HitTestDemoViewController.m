//
//  HitTestDemoViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/5/27.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "HitTestDemoViewController.h"
#import "HitTestDemoView.h"
#import "HitTestDemoSubView1.h"
@interface HitTestDemoViewController ()

@property(nonatomic,strong)HitTestDemoView *demoView;
@property(nonatomic,strong)HitTestDemoSubView1 *subView1;

@end

@implementation HitTestDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"hitTest";
    
    self.demoView = [[HitTestDemoView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.demoView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.demoView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCLick)];
    [self.demoView addGestureRecognizer:tap];
    
    self.subView1 = [[HitTestDemoSubView1 alloc] initWithFrame:CGRectMake(20, 20, 50, 150)];
    self.subView1.backgroundColor = UIColor.yellowColor;
    [self.demoView addSubview:self.subView1];
    
    UITapGestureRecognizer *tap111 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCLick111)];
    [self.subView1 addGestureRecognizer:tap111];
    
    
}

- (void)tapCLick {
    ADLog(@"%s",__func__);
}

- (void)tapCLick111 {
    ADLog(@"%s",__func__);
}
@end
