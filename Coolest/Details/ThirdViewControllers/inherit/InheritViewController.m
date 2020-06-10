//
//  InheritViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2020/6/10.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "InheritViewController.h"
#import "Inherit_Father.h"
#import "Inherit_Son.h"

@interface InheritViewController ()

@end

@implementation InheritViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Inherit_Father *father = [Inherit_Father new];
    Inherit_Son *son = [Inherit_Son new];

    
    UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeSystem];
    bt1.frame = CGRectMake(100, 100, 50, 50);
    [self.view addSubview:bt1];
    bt1.backgroundColor = [UIColor redColor];
    [bt1 addTargetSelected:^(UIButton * _Nonnull button) {
        [father eat];
    }];
    
    
    
    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeSystem];
    bt2.frame = CGRectMake(200, 100, 50, 50);
    [self.view addSubview:bt2];
    bt2.backgroundColor = [UIColor greenColor];
    [bt2 addTargetSelected:^(UIButton * _Nonnull button) {
        [son eat];
    }];
    
    
    
    UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeSystem];
       bt3.frame = CGRectMake(150, 200, 100, 100);
       [self.view addSubview:bt3];
       bt3.backgroundColor = [UIColor yellowColor];
       [bt3 addTargetSelected:^(UIButton * _Nonnull button) {
           [father log];
    }];
    
    UIButton *bt4 = [UIButton buttonWithType:UIButtonTypeSystem];
        bt4.frame = CGRectMake(150, 400, 100, 100);
        [self.view addSubview:bt4];
        bt4.backgroundColor = [UIColor blueColor];
        [bt4 addTargetSelected:^(UIButton * _Nonnull button) {
        [son log];
    }];
    
//    继承父类所有属性和方法，copy
}

@end
