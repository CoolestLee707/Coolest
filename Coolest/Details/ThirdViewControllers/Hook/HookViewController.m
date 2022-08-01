//
//  HookViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/29.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "HookViewController.h"
#import "HookObject.h"
#import "SuperView.h"
#import "SonView.h"

@interface HookViewController ()

@end

@implementation HookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HOOK";
    
//    [HookObject classEat];
//    HookObject *obj1 = [HookObject new];
//    [obj1 eat];
    
    SuperView *father = [[SuperView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    father.backgroundColor = UIColor.redColor;
    [self.view addSubview:father];
    
    
    SuperView *son = [[SuperView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    son.backgroundColor = UIColor.grayColor;
    [self.view addSubview:son];
}

@end
