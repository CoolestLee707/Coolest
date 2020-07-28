//
//  CLPermenantThread.m
//  Coolest
//
//  Created by LiChuanmin on 2020/7/28.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "CLPermenantThread.h"
@interface CLPermenantThread()
@property (strong, nonatomic) NSThread *innerThread;
//@property (assign, nonatomic, getter=isStopped) BOOL stopped;
@end

@implementation CLPermenantThread
#pragma mark - public methods
- (instancetype)init
{
    if (self = [super init]) {
//        self.stopped = NO;
        
//        __weak typeof(self) weakSelf = self;
        
        self.innerThread = [[NSThread alloc] initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            
            // 创建上下文（要初始化一下结构体）
            CFRunLoopSourceContext context = {0};
            
            // 创建source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            
            // 往Runloop中添加source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            
            // 销毁source
            CFRelease(source);
            
            // 启动
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
            
//            while (weakSelf && !weakSelf.isStopped) {
//                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//            }
        }];
        
        [self.innerThread start];
    }
    return self;
}
//- (void)run
//{
//    if (!self.innerThread) return;
//
//    [self.innerThread start];
//}

- (void)executeTask:(CLPermenantThreadTask)task
{
    if (!self.innerThread || !task) return;
    
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)stop
{
    if (!self.innerThread) return;
    
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

- (void)dealloc
{
    ADLog(@"%s", __func__);
    
    [self stop];
}

#pragma mark - private methods
- (void)__stop
{
//    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)__executeTask:(CLPermenantThreadTask)task
{
    task();
}

@end
