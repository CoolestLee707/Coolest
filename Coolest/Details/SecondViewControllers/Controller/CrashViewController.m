//
//  CrashViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2020/10/21.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "CrashViewController.h"

@interface CrashViewController ()

@end

@implementation CrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"崩溃处理";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = UIColor.redColor;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)buttonClick {
    
    NSException *exception = [NSException exceptionWithName:@"name" reason:@"reason" userInfo:nil];
    @throw exception;
    
}

@end
