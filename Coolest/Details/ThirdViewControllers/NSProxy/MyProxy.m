//
//  MyProxy.m
//  Coolest
//
//  Created by LiChuanmin on 2022/5/30.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

//对于NSProxy，接收unknown selector后，直接回调-methodSignatureForSelector:/-forwardInvocation:，消息转发过程比class NSObject要简单得多

#import "MyProxy.h"

@implementation MyProxy

+ (instancetype)proxyWithTarget:(id)target {
    // NSProxy对象不需要调用init，因为它本来就没有init方法
    MyProxy *proxy = [MyProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return NO;
}

- (void)eat {
    ADLog(@"%s",__func__);
}

@end

/*
对于class NSObject而言，接收到消息后先去自身的方法列表里找匹配的selector，如果找不到，会沿着继承体系去superclass的方法列表找；如果还找不到，先后会经过+resolveInstanceMethod:和-forwardingTargetForSelector:处理，处理失败后，才会到-methodSignatureForSelector:/-forwardInvocation:进行最后的挣扎.
        但对于NSProxy，接收unknown selector后，直接回调-methodSignatureForSelector:/-forwardInvocation:，消息转发过程比class NSObject要简单得多。
        相对于class NSObject，NSProxy的另外一个非常重要的不同点也值得注意：NSProxy会将自省相关的selector直接forward到-forwardInvocation:回调中，这些自省方法包括：

(BOOL)isKindOfClass:(Class)aClass;
(BOOL)isMemberOfClass:(Class)aClass;
(BOOL)conformsToProtocol:(Protocol *)aProtocol;
(BOOL)respondsToSelector:(SEL)aSelector;
        这4个selector的实际接收者realObject，而不是NSProxy对象本身。但另一方面，NSProxy并没有将performSelector系列selector也forward到-forwardInvocation:，换句话说，[proxy performSelector:someSelector]的真正处理者仍然是proxy自身，只是后续会将someSelector给forward到-forwardInvocation:回调，然后经由realObject处理。
*/
