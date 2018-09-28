//
//  GCDViewController.m
//  Coolest
//
//  Created by daoj on 2018/9/27.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GCD";

    [self method1];

}

- (void)method1 {
    
    //创建串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_SERIAL);
    
    //创建并发队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_CONCURRENT);
    //获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    // 同步执行任务创建方法
    dispatch_sync(mainQueue, ^{
        // 这里放同步执行任务代码
    });
    
    // 异步执行任务创建方法
    dispatch_async(mainQueue, ^{
        // 这里放异步执行任务代码
    });
    
    
}


@end
