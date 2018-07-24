//
//  UIViewController+Appear.m
//  Coolest
//
//  Created by daoj on 2018/7/24.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "UIViewController+Appear.h"
#import "NSObject+SwizzledMethod.h"

@implementation UIViewController (Appear)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzledInstanceSEL:@selector(viewWillAppear:) withSEL:@selector(swizzledViewWillAppear:)];
        
        [self swizzledInstanceSEL:@selector(viewWillDisappear:) withSEL:@selector(swizzledViewWillDisappear:)];
        
    });
}
- (void)swizzledViewWillAppear:(BOOL)animated
{
    ADLog(@"页面即将出现%@",[self class]);
    [self swizzledViewWillAppear:animated];
    
}

- (void)swizzledViewWillDisappear:(BOOL)animated
{
    ADLog(@"页面即将消失%@",[self class]);

    [self swizzledViewWillDisappear:animated];
}
@end
