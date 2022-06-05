//
//  NSProxyViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/5/30.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "NSProxyViewController.h"
#import "MyProxy.h"
#import "SonProxy.h"

@interface NSProxyViewController ()

@end

@implementation NSProxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    MyProxy *proxy = [MyProxy proxyWithTarget:self];
//    [proxy eat];
//    ADLog(@"%d",[proxy isKindOfClass:[self class]]);
    
    
    SonProxy *sonProxy = [SonProxy proxyWithTarget:self];
    [sonProxy eat];
    [sonProxy run];
    ADLog(@"%d",[sonProxy isKindOfClass:[self class]]);
}


- (void)run {
    ADLog(@"%s",__func__);
}

@end
