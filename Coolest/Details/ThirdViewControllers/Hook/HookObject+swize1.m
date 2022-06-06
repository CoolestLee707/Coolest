//
//  HookObject+swize1.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/29.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "HookObject+swize1.h"
#import <objc/runtime.h>
#import "NSObject+SwizzledMethod.h"

@implementation HookObject (swize1)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        SEL selA = @selector(eat);
        SEL selB = @selector(eat1);

//        [self swizzledInstanceSEL:selA withSEL:selB];
        
    });
}
- (void)eat1 {
    ADLog(@"%s",__func__);
    [self eat1];
}
@end
