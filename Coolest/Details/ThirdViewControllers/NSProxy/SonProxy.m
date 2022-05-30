//
//  SonProxy.m
//  Coolest
//
//  Created by LiChuanmin on 2022/5/30.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "SonProxy.h"

@implementation SonProxy

+ (instancetype)proxyWithTarget:(id)target {
    // NSProxy对象不需要调用init，因为它本来就没有init方法
    SonProxy *proxy = [SonProxy alloc];
    proxy.target = target;
    return proxy;
}

@end
