//
//  FishHookViewController.m
//  Coolest
//
//  Created by chuanmin li on 2021/9/1.
//  Copyright © 2021 CoolestLee707. All rights reserved.
//

#import "FishHookViewController.h"
#import "fishhook.h"

@interface FishHookViewController ()

@end

@implementation FishHookViewController

//原始指针
static void(*funcP)(const char * str);
//函数指针，用来保存原始的函数地址
static void(*sys_nslog)(NSString * format, ...);


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"fishhook";
    
    NSLog(@"fishhook");
    
    //交换实现-系统的函数方法
//    [self hookSysFunction];
   
    //交换-自己定义的函数
//    rebind_symbols((struct rebinding[1]){{"func",newFunc,(void **)&funcP}}, 1);
}

//----------------------

//自定义打印方法-C,fishhook勾不住自己定义的函数
void func(const char * str) {
    NSLog(@"%s",str);
}

//自定义新方法
void newFunc(const char * str) {
    NSLog(@"自定义方法勾上了");
    funcP(str);
}

//----------------------

//新的Log方法
void myNSLog(NSString * format, ...) {
    format = [format stringByAppendingString:@"勾上了"];
    //由于我们不知道NSLog的内部实现，所以保留原始调用
    sys_nslog(format);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    func("自定义的");
    NSLog(@"系统的");
}

// hook 系统的方法
- (void)hookSysFunction {
    
    //rebinding结构体
    struct rebinding nslog;
    nslog.name = "NSLog"; //需要替换的函数名称
    nslog.replacement = myNSLog; //新的函数地址
    nslog.replaced = (void *)&sys_nslog;////原始函数指针的指针
    
    //定义数组，里面放rebinding结构体
    struct rebinding rebs[1] = {nslog};
    /**
     arg1：存放rebinding结构体的数组
     arg2：数组的长度
     */
    rebind_symbols(rebs, 1);
}
@end
