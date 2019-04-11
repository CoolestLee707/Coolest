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
//    [racview.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        ADLog(@"----%@",x);
//    }];
    
    
//    Map监听文本框的内容改变，把结构重新映射成一个新值.
//    [[racview.textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
//
//        // 当源信号发出，就会调用这个block，修改源信号的内容
//        // 返回值：就是处理完源信号的内容。
//        return [NSString stringWithFormat:@"输出:%@",value];
//
//    }] subscribeNext:^(id  _Nullable x) {
//        ADLog(@"----%@",x);
//    }];
    
    
    NSArray *numbers = @[@(1),@(2),@(3),@(4),@(5)];
    
    //-----filter:h过滤掉不要的值
//    - (RACSequence<ValueType> *)filter:(BOOL (^)(id _Nullable value))block;

    
//    NSArray *result = [[[numbers rac_sequence] filter:^BOOL(NSNumber   *value) {
//        return [value intValue] %2 ==0;
//
//    }] array];
//
//    ADLog(@"results = %@",result);
//    results = (
//               2,
//               4
//               )

    
    //-----map:将值进行转换
//    NSArray *result = [[[numbers rac_sequence] map:^id _Nullable(NSNumber  *value) {
//
//        long square = [value intValue] * [value intValue];
//        return @(square);
//    }] array];
//
//     ADLog(@"results = %@",result);
    
//    results = (
//               1,
//               4,
//               9,
//               16,
//               25
//               )

    
     //------ filter + map:
    
//    NSArray *result = [[[[numbers rac_sequence] filter:^BOOL(NSNumber   *value) {
////        找出偶数
//        return [value intValue] %2 ==0;
//
//    }] map:^id _Nullable(NSNumber *value) {
//
////        找出偶数算平方
//        long square = [value intValue] * [value intValue];
//        return @(square);
//
//    }] array];
//
//    ADLog(@"results = %@",result);
    
    
//    results = (
//               4,
//               16
//               )

}


@end
