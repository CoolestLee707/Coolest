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
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}


void UncaughtExceptionHandler(NSException *exception) {
     NSArray *stackSymbolsArr = [exception callStackSymbols];
     NSString *reason = [exception reason];
     NSString *name = [exception name];
    NSDictionary *userInfo =@{@"00":@"11"};
    
    ADLog(@"reason:%@--name:%@",reason,name);
    ADLog(@"arr--%@",stackSymbolsArr);
    
    [[[CL_ExceptionHander alloc]init]performSelectorOnMainThread:@selector(cl_handleException:) withObject:[NSException exceptionWithName:name reason:reason userInfo:userInfo] waitUntilDone:YES];
    
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
