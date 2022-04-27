//
//  NSURL+CFURL.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "NSURL+CFURL.h"
#import "NSObject+SwizzledMethod.h"

@implementation NSURL (CFURL)

+ (void)load {
    
//    ADLog(@"--NSURL---load");

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
//        [self swizzledClassSEL:@selector(URLWithString:) withSEL:@selector(CF_URLWithStr:)];
        
    });
}

#pragma mark --- 使用runtime交换方法
+ (instancetype)CF_URLWithStr:(NSString *)URLString {
    //交换了两个方法
    NSURL *url = [self CF_URLWithStr:URLString];//注意这里不能再调用系统的方法
    ADLog(@"runtime url -- %@",url);

    if (!url) {
        ADLog(@"url为空");
    }
    return url;
}

+ (void)initialize {
//    ADLog(@"--NSURL-----initialize");
}

@end
