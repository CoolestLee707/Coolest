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
#import "HitTestButton.h"
#import "UIButton+TestButtonC.h"
#import "HitTestSubViewController.h"
@interface HitTestDemoViewController ()

@property(nonatomic,strong)HitTestDemoView *demoView;
@property(nonatomic,strong)HitTestDemoSubView1 *subView1;
@property(nonatomic,strong) HitTestButton *hitButton;
@property(nonatomic,strong) UIButton *buttonC;

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
    
//    self.subView1 = [[HitTestDemoSubView1 alloc] initWithFrame:CGRectMake(20, 20, 50, 150)];
    self.subView1 = [[HitTestDemoSubView1 alloc] initWithFrame:CGRectMake(120, 120, 50, 150)];
    self.subView1.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:self.subView1];
    
    UITapGestureRecognizer *tap111 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCLick111)];
    [self.subView1 addGestureRecognizer:tap111];
    
    // 扩大点击区域
    self.hitButton = [HitTestButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.hitButton];
    self.hitButton.frame = CGRectMake(100, 300, 100, 100);
    self.hitButton.backgroundColor = UIColor.blueColor;
    [self.hitButton addTargetSelected:^(UIButton * _Nonnull button) {
        ADLog(@"self.hitButton--Click");
    }];
    
    self.buttonC = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.buttonC];
    self.buttonC.frame = CGRectMake(100, 500, 100, 100);
    self.buttonC.backgroundColor = UIColor.greenColor;
//    [self.buttonC setEnlargeEdgeWithTop:20 right:30 bottom:40 left:50];
    [self.buttonC setEnLargeEdge:10];
    __weak typeof(self)weakSelf = self;
    [self.buttonC addTargetSelected:^(UIButton * _Nonnull button) {
        ADLog(@"self.buttonC--Click");
        HitTestSubViewController *vc = [HitTestSubViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (void)tapCLick {
    ADLog(@"%s",__func__);
}

- (void)tapCLick111 {
    ADLog(@"%s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ADLog(@"%s",__func__);

}
@end
