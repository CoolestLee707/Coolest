//
//  GCDViewController.m
//  Coolest
//
//  Created by daoj on 2018/9/27.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()
{
    dispatch_semaphore_t  semaphoreLock;
}

@property (nonatomic,copy) NSArray *array;

@property (nonatomic,assign)int ticketSurplusCount;

@property (nonatomic,copy) NSString *targetString;

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GCD";

//    NSMutableArray *tempArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
//
//    self.array = tempArr;
//
//    ADLog(@"tempArr+++ %@ -- %p",tempArr,tempArr);
//    ADLog(@"self.array+++ %@ -- %p",self.array,self.array);
//
//    [tempArr addObject:@"4"];
//
//    ADLog(@"tempArr--- %@ -- %p",tempArr,tempArr);
//    ADLog(@"self.array--- %@ -- %p",self.array,self.array);

//    [self method1];

//    同步执行 + 并发队列
//    [self syncConcurrent];
    
//    异步执行 + 并发队列
//    [self asyncConcurrent];
    
    
//    同步执行 + 串行队列
//    [self syncSerial];
    
//    异步执行 + 串行队列
//    [self asyncSerial];
    
//    同步执行 + 主队列
//    [self syncMain];
    
//    在其他线程中调用同步执行 + 主队列
    // 使用 NSThread 的 detachNewThreadSelector 方法会创建线程，并自动启动线程执selector 任务
//    [NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];
    
//    异步执行 + 主队列
//    [self asyncMain];
    
//    线程间通信
//    [self communication];
    
//    栅栏方法 dispatch_barrier_async
//    [self barrier];
    
//    延时执行方法 dispatch_after
//    [self after];
    
//    用于单例
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//         // 只执行1次的代码(这里面默认是线程安全的)
//    });
    
//    快速迭代方法 dispatch_apply
//    [self apply];
    
    
//    队列组 dispatch_group_notify
//    [self groupNotify];
    
//     队列组 dispatch_group_wait
//    [self groupWait];
    
//    队列组 dispatch_group_enter、dispatch_group_leave
//    [self groupEnterAndLeave];
    
//    semaphore 线程同步 -- 信号量
//    [self semaphoreSync];
    
//    非线程安全
//    [self initTicketStatusNotSave];
    
//    线程安全
//    [self initTicketStatusSave];
    
//    [self testCommunication];
    
//    [self test1];
    
//    [self test2];

//    [self test3];

//    [self test4];

//    [self test5];
    
    
//    [self test6];
    
//    [self test7];
    
    [self testNSNotificationCenter];

}

//不管你在哪个线程注册通知，发送通知在哪个线程，接受通知就会在哪个线程，即发送通知和接受通知在同一个线程，如果子线程操作UI，会打印一推日志，告诉我们应该主线程操作
- (void)testNSNotificationCenter {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xxx) name:@"xxx" object:nil];
        ADLog(@"子线程注册通知===%@",[NSThread currentThread]);
    });
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xxx) name:@"xxx" object:nil];
//    ADLog(@"主线程注册===%@",[NSThread currentThread]);
    
    UIButton *sendBtn=[[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
      sendBtn.backgroundColor=[UIColor redColor];
    [sendBtn setTitle:@"发送通知" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendNoti) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
}

-(void)sendNoti {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"xxx" object:nil];
//    ADLog(@"发送通知主线线程===%@",[NSThread currentThread]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"xxx" object:nil];
        ADLog(@"发送通知子线线程===%@",[NSThread currentThread]);
    });
}
-(void)xxx {
    ADLog(@"收到通知线程===%@",[NSThread currentThread]);
}


- (void)test7 {
    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(actionTime) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] run];//加上就执行定时器了

    });
}

- (void)actionTime {
    ADLog(@"--- %@",[NSDate date]);

}
- (void)test6 {

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
       
        ADLog(@"1");
        [self performSelector:@selector(test111) withObject:nil afterDelay:0];
        [[NSRunLoop currentRunLoop] run];

        ADLog(@"2");

    });

//  不加[[NSRunLoop currentRunLoop] run];  执行1和2，不打印3
/// 其实就是在内部创建了一个NSTimer，然后会添加到当前线程的Runloop中。子线程RunLoop默认关闭
    
//    加上[[NSRunLoop currentRunLoop] run];后打印 1 3 2，必须是先执行performSelector延迟方法之后再执行run方法。因为run方法只是尝试想要开启当前线程中的runloop，但是如果该线程中并没有任何事件(source、timer、observer)的话，并不会成功的开启。

    
}

- (void)test111 {
    ADLog(@"3");

}

- (void)test1 {
    
    ADLog(@"1---%@",[NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_CONCURRENT);

    //CPU调度耗时，主线程不堵塞执行5
    dispatch_async(queue, ^{
        
        //子线程
        
        ADLog(@"2---%@",[NSThread currentThread]);   //number = 3
        //堵塞
        dispatch_sync(queue, ^{
            ADLog(@"3---%@",[NSThread currentThread]);   //number = 3
        });
        ADLog(@"4---%@",[NSThread currentThread]);   //number = 3
    });
    
    ADLog(@"5---%@",[NSThread currentThread]);

    //1 5 2 3 4
}

- (void)test2 {
    
    ADLog(@"1---%@",[NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_CONCURRENT);
    
    //CPU调度耗时，主线程不堵塞执行5
    dispatch_async(queue, ^{
        
        //子线程
        
        ADLog(@"2---%@",[NSThread currentThread]);   //number = 3
        
        dispatch_async(queue, ^{
            ADLog(@"3---%@",[NSThread currentThread]);  //number = 4，又开启一条新线程
        });
        ADLog(@"4---%@",[NSThread currentThread]);   //number = 3
    });
    
    ADLog(@"5---%@",[NSThread currentThread]);
    
    //1 5 2 4 3
}

#pragma mark 严重堵塞卡死
- (void)test3 {
    
    ADLog(@"1---%@",[NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_SERIAL);
    
    //CPU调度耗时，主线程不堵塞执行5
    dispatch_async(queue, ^{
        
        //子线程
        
        ADLog(@"2---%@",[NSThread currentThread]);   //number = 3
        //堵塞-串行队列正在执行异步任务，互相等待中。。
        dispatch_sync(queue, ^{
            ADLog(@"3---%@",[NSThread currentThread]);
        });
        ADLog(@"4---%@",[NSThread currentThread]);
    });
    
    ADLog(@"5---%@",[NSThread currentThread]);
    
    //1 5 2
}

- (void)test4 {
    
    ADLog(@"1---%@",[NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_SERIAL);
    
    //CPU调度耗时，主线程不堵塞执行5
    dispatch_async(queue, ^{
        
        //子线程
        
        ADLog(@"2---%@",[NSThread currentThread]);   //number = 3
        dispatch_async(queue, ^{
            ADLog(@"3---%@",[NSThread currentThread]);  //number = 3，异步执行具备开启新线程的能力，串行队列只开启一个线程
        });
        ADLog(@"4---%@",[NSThread currentThread]);   //number = 3
    });
    
    ADLog(@"5---%@",[NSThread currentThread]);
    
    //1 5 2 4 3
}

- (void)test5 {
    
    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_CONCURRENT);
    for (int i=0; i<100; i++) {
        dispatch_async(queue, ^{
            
            self.targetString = [NSString stringWithFormat:@"%d",i];
        });
    }
    
//    把任务添加到并发队列中，全部添加完以后打印的时候不确定哪个任务完成修改了targetString的值
    ADLog(@"---1----- %@",self.targetString);
    ADLog(@"---2----- %@",self.targetString);
    ADLog(@"---3----- %@",self.targetString);

}
- (void)testCommunication {
    
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        
        // 异步追加任务
        for (int i = 0; i < 20; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"0---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        
        // 异步追加任务
        for (int i = 0; i < 10; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
        
        // 回到主线程
        dispatch_async(mainQueue, ^{
            
            // 追加在主线程中执行的任务
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
}

#pragma mark ---线程安全：使用 semaphore 加锁, 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
- (void)initTicketStatusSave {
    
    ADLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    ADLog(@"semaphore---begin");
    
    semaphoreLock = dispatch_semaphore_create(1);
    
    self.ticketSurplusCount = 50;
    
    // queue1 代表北京火车票售卖窗口
    dispatch_queue_t queue1 = dispatch_queue_create("net.bujige.testQueue1", DISPATCH_QUEUE_SERIAL);
    // queue2 代表上海火车票售卖窗口
    dispatch_queue_t queue2 = dispatch_queue_create("net.bujige.testQueue2", DISPATCH_QUEUE_SERIAL);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue1, ^{
        [weakSelf saleTicketSafe];
    });
    
    dispatch_async(queue2, ^{
        [weakSelf saleTicketSafe];
    });
    
}

#pragma mark --- 售卖火车票(线程安全)
- (void)saleTicketSafe {
    while (1) {
        // 相当于加锁
        dispatch_semaphore_wait(semaphoreLock, DISPATCH_TIME_FOREVER);
        
        if (self.ticketSurplusCount > 0) {  //如果还有票，继续售卖
            self.ticketSurplusCount--;
            ADLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else { //如果已卖完，关闭售票窗口
            ADLog(@"所有火车票均已售完");
            
            // 相当于解锁
            dispatch_semaphore_signal(semaphoreLock);
            break;
        }
        
        // 相当于解锁
        dispatch_semaphore_signal(semaphoreLock);
    }
}


#pragma mark --- * 非线程安全：不使用 semaphore ,* 初始化火车票数量、卖票窗口(非线程安全)、并开始卖票
- (void)initTicketStatusNotSave {
    ADLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    ADLog(@"semaphore---begin");
    
    self.ticketSurplusCount = 50;
    
    // queue1 代表北京火车票售卖窗口
    dispatch_queue_t queue1 = dispatch_queue_create("net.bujige.testQueue1", DISPATCH_QUEUE_SERIAL);
    // queue2 代表上海火车票售卖窗口
    dispatch_queue_t queue2 = dispatch_queue_create("net.bujige.testQueue2", DISPATCH_QUEUE_SERIAL);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue1, ^{
        [weakSelf saleTicketNotSafe];
    });
    
    dispatch_async(queue2, ^{
        [weakSelf saleTicketNotSafe];
    });
}

#pragma mark --- 售卖火车票(非线程安全)
- (void)saleTicketNotSafe {
    while (1) {
        
        if (self.ticketSurplusCount > 0) {  //如果还有票，继续售卖
            self.ticketSurplusCount--;
            ADLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else { //如果已卖完，关闭售票窗口
            ADLog(@"所有火车票均已售完");
            break;
        }
    }
}

#pragma mark ---  semaphore 线程同步 -- 信号量
- (void)semaphoreSync {
    
    ADLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    ADLog(@"semaphore---begin");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);//设置信号量初始值
    
    __block int number = 0;
    dispatch_async(queue, ^{
        // 追加任务1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        
        number = 100;
        
        dispatch_semaphore_signal(semaphore);//任务完成，信号量+1
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//只有信号量>0时，才执行后面的代码，信号量-1；否则，处于等待状态。
    ADLog(@"semaphore---end,number = %d",number);
}

#pragma mark ---  队列组 dispatch_group_enter、dispatch_group_leave
- (void)groupEnterAndLeave
{
    ADLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    ADLog(@"group---begin");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程.
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
        ADLog(@"group---end");
    });
    
    //    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    //    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //
    //    ADLog(@"group---end");
}


#pragma mark ---  队列组 dispatch_group_wait
- (void)groupWait {
    ADLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    ADLog(@"group---begin");
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    ADLog(@"group---end");
}


#pragma mark ---   队列组 dispatch_group_notify
- (void)groupNotify {
    
    ADLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    ADLog(@"group---begin");
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
        ADLog(@"group---end");
    });
    
    ADLog(@"group---======");

}

#pragma mark ---   快速迭代方法 dispatch_apply
- (void)apply {

//    全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    ADLog(@"apply---begin");
    
    dispatch_apply(6, queue, ^(size_t index) {
        ADLog(@"%zd---%@",index, [NSThread currentThread]);
        
    });
    ADLog(@"apply---end");
}

#pragma mark ---   延时执行方法 dispatch_after
- (void)after {
    ADLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    ADLog(@"after---begin");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2.0秒后异步追加任务代码到主队列，并开始执行
        ADLog(@"after---%@",[NSThread currentThread]);  // 打印当前线程
    });
}
#pragma mark ---  栅栏方法 dispatch_barrier_async
- (void)barrier {
    
//    仅对自己创建的并发队列有效
    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_CONCURRENT);

    //全局并发队列无效哈哈
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_barrier_async(queue, ^{
        // 追加任务 barrier
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"barrier---%@",[NSThread currentThread]);// 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        // 追加任务4
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"4---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
}
#pragma mark --- 线程间通信
- (void)communication {
    
     // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        
        // 异步追加任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
        
        // 回到主线程
        dispatch_async(mainQueue, ^{
            
            // 追加在主线程中执行的任务
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
}
#pragma mark --- 异步执行 + 主队列，特点：只在主线程中执行任务，执行完一个任务，再执行下一个任务
- (void)asyncMain {
    ADLog(@"currentThread---%@",[NSThread currentThread]);
    ADLog(@"asyncMain---begin");
    dispatch_queue_t queue = dispatch_get_main_queue();

    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    ADLog(@"asyncMain---end");
}
#pragma mark --- 同步执行 + 主队列，特点：特点(主线程调用)：互等卡主不执行。 特点(其他线程调用)：不会开启新线程，执行完一个任务，再执行下一个任务。
- (void)syncMain {
    
    ADLog(@"currentThread---%@",[NSThread currentThread]);
    ADLog(@"syncMain---begin");
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_sync(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_sync(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    ADLog(@"syncMain---end");
}
#pragma mark --- 异步执行 + 串行队列，特点：会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
- (void)asyncSerial {
    ADLog(@"currentThread---%@",[NSThread currentThread]);
    ADLog(@"asyncSerial---begin");
    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    ADLog(@"asyncSerial---end");
}
#pragma mark --- 同步执行 + 串行队列，特点：不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
- (void)syncSerial {
    ADLog(@"currentThread---%@",[NSThread currentThread]);
    ADLog(@"syncSerial---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_sync(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_sync(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    ADLog(@"syncSerial---end");
}

#pragma mark --- 异步执行 + 并发队列，特点：可以开启多个线程，任务交替（同时）执行。
- (void)asyncConcurrent {
    ADLog(@"currentThread---%@",[NSThread currentThread]);
    ADLog(@"asyncConcurrent---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    ADLog(@"asyncConcurrent---end");
}
#pragma mark --- 同步执行 + 并发队列，特点：在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
- (void)syncConcurrent {
    ADLog(@"currentThread---%@",[NSThread currentThread]);
    ADLog(@"syncConcurrent---begin");

    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_sync(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_sync(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            ADLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    ADLog(@"syncConcurrent---end");
}
- (void)method1 {
    
    /*
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
    
    */
}


@end
