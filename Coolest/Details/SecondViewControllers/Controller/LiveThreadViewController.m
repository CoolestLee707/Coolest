//
//  LiveThreadViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2020/7/28.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "LiveThreadViewController.h"
#import "CLThread.h"
#import "CLPermenantThread.h"

@interface LiveThreadViewController ()

@property (strong, nonatomic) CLThread *thread;
@property (assign, nonatomic, getter=isStoped) BOOL stopped;

@property (strong, nonatomic) CLPermenantThread *CLPThread;

@end

@implementation LiveThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"RunLoop-线程保活";
    
    
//    [self test1];
    
    [self test2];

}

- (void)test2 {
    self.CLPThread = [[CLPermenantThread alloc] init];

    UIButton *addTaskButton = [UIButton buttonWithType:UIButtonTypeSystem];
    addTaskButton.frame = CGRectMake(Main_Screen_Width/2-50, 200, 100, 100);
    addTaskButton.backgroundColor = [UIColor greenColor];
    [addTaskButton setTitle:@"添加任务" forState:UIControlStateNormal];
    [self.view addSubview:addTaskButton];
    [addTaskButton addTarget:self action:@selector(addTaskButtonClick1) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeSystem];
    stopButton.frame = CGRectMake(Main_Screen_Width/2-50, 400, 100, 100);
    stopButton.backgroundColor = [UIColor orangeColor];
    [stopButton setTitle:@"杀死线程" forState:UIControlStateNormal];
    [self.view addSubview:stopButton];
    [stopButton addTarget:self action:@selector(stopButtonClick1) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addTaskButtonClick1 {
    [self.CLPThread executeTask:^{
        NSLog(@"执行任务 - %@", [NSThread currentThread]);
    }];
}
- (void)stopButtonClick1 {
    [self.CLPThread stop];

}
- (void)test1 {
    UIButton *addTaskButton = [UIButton buttonWithType:UIButtonTypeSystem];
    addTaskButton.frame = CGRectMake(Main_Screen_Width/2-50, 200, 100, 100);
    addTaskButton.backgroundColor = [UIColor greenColor];
    [addTaskButton setTitle:@"添加任务" forState:UIControlStateNormal];
    [self.view addSubview:addTaskButton];
    [addTaskButton addTarget:self action:@selector(addTaskButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeSystem];
    stopButton.frame = CGRectMake(Main_Screen_Width/2-50, 400, 100, 100);
    stopButton.backgroundColor = [UIColor orangeColor];
    [stopButton setTitle:@"杀死线程" forState:UIControlStateNormal];
    [self.view addSubview:stopButton];
    [stopButton addTarget:self action:@selector(stopButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    __weak typeof(self)weakSelf = self;
    
    self.stopped = NO;
    
    self.thread = [[CLThread alloc]initWithBlock:^{
        ADLog(@"%@----begin----", [NSThread currentThread]);
        
        // 往RunLoop里面添加Source\Timer\Observer
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        while (weakSelf && !weakSelf.isStoped) {
            ADLog(@"--runBefore---");
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            ADLog(@"--runAfter---");
        }
        
        ADLog(@"%@----end----", [NSThread currentThread]);
        
    }];
    
    [self.thread start];
}

- (void)addTaskButtonClick {
    
    if (!self.thread) return;
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

// 子线程需要执行的任务
- (void)test {
    ADLog(@"%s %@", __func__, [NSThread currentThread]);
}

- (void)stopButtonClick {
    
    if (!self.thread) return;
    
    // 在子线程调用stop
    [self performSelector:@selector(stopThread) onThread:self.thread withObject:nil waitUntilDone:YES];
}

// 用于停止子线程的RunLoop
- (void)stopThread
{
    // 设置标记为NO
    self.stopped = YES;
    
    // 停止RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    ADLog(@"%s %@", __func__, [NSThread currentThread]);
    
    self.thread = nil;
}

- (void)dealloc
{
    ADLog(@"%s", __func__);
    
    [self stopButtonClick];
}


@end
