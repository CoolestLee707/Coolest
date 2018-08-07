//
//  FingerprintPasswordViewController.m
//  Coolest
//
//  Created by daoj on 2018/8/7.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "FingerprintPasswordViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface FingerprintPasswordViewController ()

@end

@implementation FingerprintPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)addClick
{
//    获得当前系统版本号,判断版本
    if (VERSION < 8.0) {
        return;
    }
    
//    实例化指纹识别对象,判断当前设备是否支持指纹识别功能(是否带有TouchID)
    // 1> 实例化指纹识别对象
    LAContext *laCtx = [[LAContext alloc] init];
    
    // 2> 判断当前设备是否支持指纹识别功能.
    if (![laCtx canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL]) {
        // 如果设备不支持指纹识别功能
        ADLog(@"该设备不支持指纹识别功能");
        return;
    }
   
//    3> 指纹登陆(默认是异步方法)
    [laCtx evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"指纹登陆" reply:^(BOOL success, NSError *error) {
        // 如果成功,表示指纹输入正确.
        if (success) {
            ADLog(@"指纹识别成功!");
            
        } else {
            ADLog(@"指纹识别错误,请再次尝试");
        }
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
