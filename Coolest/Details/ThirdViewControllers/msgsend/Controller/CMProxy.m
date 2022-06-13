//
//  CMProxy.m
//  Coolest
//
//  Created by LiChuanmin on 2022/6/13.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "CMProxy.h"

@implementation CMProxy

- (id)initWithObject:(id)object {

    self.target = object;

    return self;

}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {

    return [self.target methodSignatureForSelector:selector];

}

- (void)forwardInvocation:(NSInvocation *)invocation {

    [invocation invokeWithTarget:self.target];

}
@end
