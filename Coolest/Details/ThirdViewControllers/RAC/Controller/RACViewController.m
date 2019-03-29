//
//  RACViewController.m
//  Coolest
//
//  Created by daoj on 2019/3/27.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "RACViewController.h"
#import "RACView.h"
#import <NSObject+RACKVOWrapper.h>
@interface RACViewController ()

@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RAC响应式编程";
    
    
    RACView *racview = [[RACView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height-kNavigationBarHeight)];
    
    [self.view addSubview:racview];
    
//    信号
//    [racview.racSingnal subscribeNext:^(id  _Nullable x) {
//        ADLog(@"----%@",x);
//    }];
    
    
//    方法->信号
//    [[racview rac_signalForSelector:@selector(btnClcik:)]subscribeNext:^(RACTuple * _Nullable x) {
//        ADLog(@"----%@",x);
//    }];
    
    
//    KVO
//    [racview rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
//         ADLog(@"变化");
//    }];
    
//    属性->信号
//    [[racview rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable x) {
//         ADLog(@"----%@",x);
//    }];
    
    //通知
//    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        ADLog(@"----%@",x);
//    }];
    
//    textField代理方法
    [racview.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        ADLog(@"----%@",x);
    }];
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
