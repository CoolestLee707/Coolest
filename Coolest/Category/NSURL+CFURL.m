//
//  NSURL+CFURL.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "NSURL+CFURL.h"
#import <objc/runtime.h>

@implementation NSURL (CFURL)

+ (void)load {
    //最早的方法，比main还早
    NSLog(@"load");
    //1.拿到两个Method
    //2.进行方法交换
    Method m1 = class_getClassMethod([NSURL class], @selector(URLWithString:));
    Method m2 = class_getClassMethod([NSURL class], @selector(CF_URLWithStr:));
    //利用runtime进行方法的交换
    method_exchangeImplementations(m1, m2);
    
}

#pragma mark --- 使用runtime交换方法
+ (instancetype)CF_URLWithStr:(NSString *)URLString {
    //交换了两个方法
    NSURL *url = [self CF_URLWithStr:URLString];//注意这里不能再调用系统的方法
    if (!url) {
        ADLog(@"url为空");
    }
    return url;
}

@end
