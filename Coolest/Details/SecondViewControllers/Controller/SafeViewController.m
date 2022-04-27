//
//  SafeViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/23.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "SafeViewController.h"
#import "fishhook.h"
#import <objc/runtime.h>
#import <Aspects/Aspects.h>

@interface SafeViewController ()

@end

@implementation SafeViewController

//基本防护测试
+ (void)load{
    struct rebinding bd0;
    bd0.name ="method_exchangeImplementations";
    bd0.replacement = myExchange;
    bd0.replaced = (void *)&exchangeP;
    
    struct rebinding bd1;
    bd1.name = "method_setImplementation";
    bd1.replacement = myExchange;
    bd1.replaced = (void *)setIMP;
    
    struct rebinding bd2;
    bd2.name= "method_getImplementation";
    bd2.replacement = myExchange;
    bd2.replaced =  (void *)getIMP;
    
    struct rebinding rebindings[] = {bd0,bd1,bd2};
//    rebind_symbols(rebindings, 3);
}

//保留原来函数的交换函数
void (* exchangeP)(Method _Nonnull m1, Method _Nonnull m2);
IMP _Nonnull (* setIMP)(Method _Nonnull m, IMP _Nonnull imp);
IMP _Nonnull (* getIMP)(Method _Nonnull m);
//新的函数
void myExchange(Method _Nonnull m1, Method _Nonnull m2){
    NSLog(@"TM 检测到了hook");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"基本防护-隐藏runtime-hook方法";

    UIButton * cusBtn = [[UIButton alloc]init];
    [cusBtn addTarget:self action:@selector(customBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cusBtn setTitle:@"测试点击" forState:UIControlStateNormal];
    [cusBtn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:cusBtn];
    cusBtn.frame = CGRectMake(100, 100, 100, 100);
    [[self class] aspect_hookSelector:@selector(customBtnClick) withOptions:AspectPositionInstead usingBlock:^{
        NSLog(@"自定义的按钮点击----被hook了！！！！！！！！");
    } error:nil];
    
}

- (void)customBtnClick{
    NSLog(@"自定义的按钮点击----没有hook？？？？？？？？？");
}

@end
