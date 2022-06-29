//
//  RunLoopViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/18.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic, strong) NSThread *thread1;

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RunLoopViewController";
    
    [self test1];
    
//    [self aboutRunloop];
    
}

- (void)test1 {
    __weak __typeof(self) weakSelf = self;
//    self.timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [weakSelf printlog];
//    }];
//    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
//
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{

        __strong __typeof(weakSelf) strongSelf = weakSelf;

        ADLog(@"---%@",[NSThread currentThread]);

        if (strongSelf) {
            strongSelf.thread1 = [NSThread currentThread];
            [strongSelf.thread1 setName:@"线程A"];
            strongSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:strongSelf selector:@selector(printlog) userInfo:nil repeats:YES];
            NSRunLoop *runloop = [NSRunLoop currentRunLoop];
            [runloop addTimer:strongSelf.timer forMode:NSRunLoopCommonModes];
            [runloop run];
        }

        
//        ADLog(@"---%@",[NSThread currentThread]);
//        self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(printlog) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
//        [[NSRunLoop currentRunLoop] run];

    });
}
- (void)aboutRunloop {
    [self performSelector:@selector(printlog1) withObject:nil afterDelay:5];
    NSLog(@"0");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSLog(@"1");
        
//     [[NSRunLoop currentRunLoop] run]; //在这启动runloop不会成功，因为没有source事件（打印：1->3）
        
    [self performSelector:@selector(test) withObject:nil afterDelay:5];
        
//      [[NSRunLoop currentRunLoop] run];
     //在这启动runloop会成功，因为有了timer事件,runloop启动之后立马执行timer事件，timer事件执行完才会执行后续的事件所以先打印2在打印3（打印：1->2->3）
    
    NSLog(@"3");
    [[NSRunLoop currentRunLoop] run];
        //在这启动runloop会成功，因为有了timer事件（打印：1->3->2）
    });
}
- (void)test {
    NSLog(@"2");
}

- (void)printlog {
    ADLog(@"%s----%@---%@",__func__,[NSThread currentThread],[NSRunLoop currentRunLoop]);
}
- (void)printlog1 {
    ADLog(@"%s",__func__);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ADLog(@"%s----%@---",__func__,[NSThread currentThread]);

//    if (self.timer) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
    
//    [self.timer invalidate];
//    self.timer = nil;
//    if (self.timer && self.thread1) {
//
    [self performSelector:@selector(cancel) onThread:self.thread1 withObject:nil waitUntilDone:YES];
    
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_async(queue, ^{
//        ADLog(@"---%@",[NSThread currentThread]);
//        [self.timer invalidate];
//        self.timer = nil;
//        ADLog(@"----");
//    });
    
}
- (void)cancel{
    ADLog(@"%s----%@---%@",__func__,[NSThread currentThread],[NSRunLoop currentRunLoop]);

    if (self.timer) {
 
        [self.timer invalidate];
 
        self.timer = nil;
 
    }
}

- (void)dealloc {
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    ADLog(@"dealloc");
}
@end
