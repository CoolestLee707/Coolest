//
//  NSThreadViewController.m
//  Coolest
//
//  Created by daoj on 2018/9/26.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "NSThreadViewController.h"

@interface NSThreadViewController ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,assign) NSInteger ticketSurplusCount;
@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"NSThread";

//    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:self.imageView];
    
    [self initTicketStatusSave];
    
}

/**
 * 创建一个线程下载图片
 */
- (void)method3
{
    // 在创建的子线程中调用downloadImage下载图片
    [NSThread detachNewThreadSelector:@selector(downloadImage) toTarget:self withObject:nil];
}
/**
 * 下载图片，下载完之后回到主线程进行 UI 刷新
 */
- (void)downloadImage {
    NSLog(@"current thread -- %@", [NSThread currentThread]);
    
    // 1. 获取图片 imageUrl
    NSURL *imageUrl = [NSURL URLWithString:@"https://ysc-demo-1254961422.file.myqcloud.com/YSC-phread-NSThread-demo-icon.jpg"];
    // 2. 从 imageUrl 中读取数据(下载图片) -- 耗时操作
    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
    // 通过二进制 data 创建 image
    UIImage *image = [UIImage imageWithData:imageData];
    
    // 3. 回到主线程进行图片赋值和界面刷新
    [self performSelectorOnMainThread:@selector(refreshOnMainThread:) withObject:image waitUntilDone:YES];
}
/**
 * 回到主线程进行图片赋值和界面刷新
 */
- (void)refreshOnMainThread:(UIImage *)image {
    NSLog(@"current thread -- %@", [NSThread currentThread]);
    
    // 赋值图片到imageview
    self.imageView.image = image;
}

- (void)method1
{
//    1.1创建线程
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
//    1.2线程名字
    thread.name = @"threadName";
//    1.3启动线程,线程一启动，就会在线程thread中执行self的run方法
    [thread start];
}

- (void)method2
{
 
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];

//    if (@available(iOS 10.0, *)) {
//        [NSThread detachNewThreadWithBlock:^{
//
//        }];
//    } else {
//        // Fallback on earlier versions
//    }
}


//新线程调用方法，里边为需要执行的任务
- (void)run
{
    ADLog(@"%@",[NSThread currentThread]);
}


//售卖火车票
/**
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */
- (void)initTicketStatusSave {
    // 1. 设置剩余火车票为 50
    self.ticketSurplusCount = 50;
    
    // 2. 设置北京火车票售卖窗口的线程
    NSThread *ticketSaleWindow1 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    ticketSaleWindow1.name = @"北京火车票售票窗口";
    
    // 3. 设置上海火车票售卖窗口的线程
    NSThread *ticketSaleWindow2 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicketSafe) object:nil];
    ticketSaleWindow2.name = @"上海火车票售票窗口";
    
    // 4. 开始售卖火车票
    [ticketSaleWindow1 start];
    [ticketSaleWindow2 start];
    
}
/**
 * 售卖火车票(线程安全)
 */
- (void)saleTicketSafe {
    while (1) {
        // 互斥锁
        @synchronized (self) {
            //如果还有票，继续售卖
            if (self.ticketSurplusCount > 0) {
                self.ticketSurplusCount --;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", self.ticketSurplusCount, [NSThread currentThread].name]);
//                模拟耗时操作
                [NSThread sleepForTimeInterval:0.2];
            }
            //如果已卖完，关闭售票窗口
            else {
                NSLog(@"所有火车票均已售完");
                break;
            }
        }
    }
}

- (void)dealloc
{
    ADLog(@"dealloc");
}
@end
