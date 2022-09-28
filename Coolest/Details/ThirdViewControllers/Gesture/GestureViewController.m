//
//  GestureViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/9/7.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "GestureViewController.h"
//#include <libkern/OSAtomic.h>
#include <execinfo.h>

@interface GestureViewController ()
@property (nonatomic,copy) void(^block)(void);

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手势";
    
    __weak typeof(self)weakSelf = self;
    self.block = ^{

        __strong typeof(self)strongSelf = weakSelf;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
   //            这里写延长生命周期无效
   //            __strong typeof(self)strongSelf = weakSelf;
               NSLog(@"--- %@",strongSelf.title);
           });
       };
    self.block();
    
    [self test1];
}

- (void)test1 {
    
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    v1.backgroundColor = UIColor.redColor;
    [self.view addSubview:v1];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 100, 100);
    btn1.backgroundColor = UIColor.yellowColor;
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
//    默认YES.阻止事件传递，button上添加手势，只响应手势，设置为NO，button和手势事件都可以响应了
//    tap.cancelsTouchesInView = NO;
//    [v1 addGestureRecognizer:tap];
    
    
//    button上添加其他手势不会影响不会影响button响应
    UIPanGestureRecognizer *pang = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan)];
    [v1 addGestureRecognizer:pang];
    [v1 addSubview:btn1];

}

- (void)tapClick {
    ADLog(@"tapClick");
}

- (void)pan {
    ADLog(@"pan");
}

- (void)btn1Click {
    ADLog(@"btnClick");
    NSArray * arr = [self backtrace];
    NSLog(@"%@",arr);
}

//获取调用堆栈
- (NSArray *)backtrace {
    
    //指针列表
    void* callstack[128];
    //backtrace用来获取当前线程的调用堆栈，获取的信息存放在这里的callstack中
    //128用来指定当前的buffer中可以保存多少个void*元素
    //返回值是实际获取的指针个数
    int frames = backtrace(callstack, 128);
    //backtrace_symbols将从backtrace函数获取的信息转化为一个字符串数组
    //返回一个指向字符串数组的指针
    //每个字符串包含了一个相对于callstack中对应元素的可打印信息，包括函数名、偏移地址、实际返回地址
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = 0; i < frames; i++) {
        
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
    return backtrace;
}






@end
