//
//  CMObject.m
//  Coolest
//
//  Created by LiChuanmin on 2022/6/13.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "CMObject.h"

@implementation CMObject

- (id)initWithObject:(id)object {

    self = [super init];

    if (self) {

        self.target = object;

    }

    return self;

}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {

    return [self.target methodSignatureForSelector:selector];

}

- (void)forwardInvocation:(NSInvocation *)invocation {

    [invocation invokeWithTarget:self.target];

}
@end
