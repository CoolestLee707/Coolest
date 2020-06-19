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
#import <objc/message.h>

@interface InheritViewController ()

@property (nonatomic,strong)Inherit_Father *father6;
@property (nonatomic,strong)UILabel *textLabel;

@property (nonatomic ,copy)NSString *name;
@property(nonatomic,copy)void(^Block)(NSString *result);

@property(nonatomic,copy)void(^noUseBlock)(InheritViewController *vc);


@end

@implementation InheritViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.name = @"000";

//    [self test1];
//
//    [self test2];
//
//    [self test3];
//
//    [self test4];
    
    
    [self testInherit];
    

}

#pragma mark --- 1.weakself打破循环引用
- (void)test1 {
    
    __weak typeof(self) weakSelf = self;
    
    self.Block = ^(NSString *result) {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            ADLog(@"%@", weakSelf.name);
        });
    };
    
    self.Block(@"complete");
}

#pragma mark --- 2.强持有，作用域
- (void)test2 {
    
    __weak typeof(self) weakSelf = self;
    
    self.Block = ^(NSString *result) {

        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            ADLog(@"%@", strongSelf.name);
        });
    };
    
    self.Block(@"complete");
}

#pragma mark --- 3.其他中间者模式,把self拷贝到堆，但是只要不调用block，仍然存在着循环应用，看4
- (void)test3 {
    
    __block InheritViewController *vc = self;
    
    self.Block = ^(NSString *result) {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

    //  3.其他中间者模式
            ADLog(@"%@", vc.name);
            vc = nil;
        });

    };
        
    // 但是只要不调用block，仍然存在着循环应用，无法手动nil，看4
    self.Block(@"complete");
    
}

#pragma mark --- 4.解决循环引用还有一种方式——不引用,self做参数
- (void)test4 {
    
        self.noUseBlock = ^(InheritViewController *vc) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                ADLog(@"%@", vc.name);
            });
        };
        
    //    不引用就不会传self，就不会循环引用
        self.noUseBlock(self);
}


- (void)bt6Click {
    
    __weak typeof(self)weakSelf = self;

    self.father6 = [Inherit_Father new];
    [self.father6 delay:^(NSString * _Nonnull result) {
        ADLog(@"******* %@",result);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.textLabel.text = result;
        });
    }];
}

- (void)delay
{
//    外部引用
    
    
//    [NSThread sleepForTimeInterval:3];//主线程--等
    
    //直接返回结果还有
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//         if (self.callBack) {
//           self.callBack(@"123231231");
//       }
//    });
    
    
    //直接返回结果还有
    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        sleep(5);
        if (self.callBack) {
            self.callBack(@"123231231");
        }
    });
    
}
- (void)testOne {
    
    __weak typeof(self)weakSelf = self;
    
    UIButton *bt5 = [UIButton buttonWithType:UIButtonTypeSystem];
    bt5.frame = CGRectMake(150, 550, 100, 100);
    [self.view addSubview:bt5];
    bt5.backgroundColor = [UIColor blackColor];
    [bt5 addTargetSelected:^(UIButton * _Nonnull button) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
        [weakSelf delay];
    }];
    
    
      
    UIButton *bt6 = [UIButton buttonWithType:UIButtonTypeSystem];
    bt6.frame = CGRectMake(150, 700, 100, 100);
    [self.view addSubview:bt6];
    bt6.backgroundColor = [UIColor brownColor];
    [bt6 addTarget:self action:@selector(bt6Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 810, 100, 50)];
    [self.view addSubview:self.textLabel];
    self.textLabel.backgroundColor = [UIColor purpleColor];
}

- (void)testInherit
{
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
        
    //    继承父类所有属性，copy
    
//    Class classone = object_getClass(father);
//    Class classtwo = object_getClass([Inherit_Father class]);
//    Class classthree = object_getClass(@"Inherit_Father");
//
//    ADLog(@"%d---%d---%d",class_isMetaClass(classone),class_isMetaClass(classtwo),class_isMetaClass(classthree));

    
    
    Class fatherClassOne = [father class];
//    Class fatherClassTwo = [Inherit_Father class];
//    Class fatherClassThree = object_getClass(@"Inherit_Father");
//    Class fatherClassFour = object_getClass(father);
//
//
    Class fatherMetaClass = object_getClass(fatherClassOne);
    
//    (lldb) p/x (long)father ->isa
//    (long) $0 = 0x000081a103750115
//    (lldb) p/x (long)fatherClassOne
//    (long) $1 = 0x0000000103750110
//    (lldb)
    
    
    ADLog(@"%p--%p--%p",father,fatherClassOne,fatherMetaClass);

}


- (void)dealloc
{
    ADLog(@"over");
}
@end
