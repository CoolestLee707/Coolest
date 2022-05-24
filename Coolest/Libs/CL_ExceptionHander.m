//
//  CL_ExceptionHander.m
//  Coolest
//
//  Created by LiChuanmin on 2020/10/21.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "CL_ExceptionHander.h"

static BOOL dismissed;

@implementation CL_ExceptionHander

+(void)setupExceptionHandler {
    
//    NSSetUncaughtExceptionHandler接收的参数是一个函数指针，该函数需要我们实现。当程序发生异常崩溃时，该函数会得到调用，所以我们对于异常的处理都是写在这个函数里。但是他无法处理内存访问错误、重复释放等错误，因为这些错误发送的SIGNAL。所以需要处理这些SIGNAL，所以我们还要设置处理SIGNAL的函数。
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);

}

void UncaughtExceptionHandler(NSException *exception) {
    
//    异常的堆栈信息
    NSArray *stackSymbolsArr = [exception callStackSymbols];
//    出现异常的原因
    NSString *reason = [exception reason];
//    异常名称
    NSString *name = [exception name];
    NSDictionary *userInfo =@{@"00":@"11"};
    
    ADLog(@"reason:%@--name:%@",reason,name);
    ADLog(@"arr--%@",stackSymbolsArr);
    
    [[[CL_ExceptionHander alloc]init] performSelectorOnMainThread:@selector(cl_handleException:) withObject:[NSException exceptionWithName:name reason:reason userInfo:userInfo] waitUntilDone:YES];
    
}

- (void)cl_handleException:(NSException *)exception {
    
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFArrayRef arraymodes = CFRunLoopCopyAllModes(runloop);
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:exception.reason message:exception.name preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"崩溃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        dismissed = YES;
       
    }];
    [alertController addAction:again];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    
    while (!dismissed) {
        
        for (NSString *mode in (__bridge NSArray *)arraymodes) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.0001, false);
        }
    }
    
    CFRelease(arraymodes);
}
@end
