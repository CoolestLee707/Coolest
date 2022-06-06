//
//  HookObject.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/29.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "HookObject.h"
#import "NSObject+SwizzledMethod.h"

@implementation HookObject

+(void)initialize {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzledClassSEL:@selector(classEat) withSEL:@selector(newClassEat)];
        [self swizzledInstanceSEL:@selector(eat) withSEL:@selector(newEat)];
    });
}
- (void)eat {
    ADLog(@"%s",__func__);
}

- (void)newEat {
    ADLog(@"%s",__func__);
}

+ (void)classEat {
    ADLog(@"%s",__func__);
}

+ (void)newClassEat {
    ADLog(@"%s",__func__);
}
@end
