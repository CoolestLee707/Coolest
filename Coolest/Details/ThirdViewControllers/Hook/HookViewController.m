//
//  HookViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/29.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "HookViewController.h"
#import "HookObject.h"

@interface HookViewController ()

@end

@implementation HookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HOOK";
    
    [HookObject classEat];
    HookObject *obj1 = [HookObject new];
    [obj1 eat];
    
}

@end
