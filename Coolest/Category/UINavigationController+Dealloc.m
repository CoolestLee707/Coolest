//
//  UINavigationController+Dealloc.m
//  Coolest
//
//  Created by LiChuanmin on 2022/6/5.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "UINavigationController+Dealloc.h"
#import "NSObject+SwizzledMethod.h"
#import <objc/runtime.h>

static char key;

@implementation UINavigationController (Dealloc)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
//    hook push/pop
    [self swizzledInstanceSEL:@selector(popViewControllerAnimated:) withSEL:@selector(swizzledPopViewControllerAnimated:)];
            
    [self swizzledInstanceSEL:@selector(pushViewController:animated:) withSEL:@selector(swizzledPushViewController:animated:)];

    });
}

// pop
- (void)swizzledPopViewControllerAnimated:(BOOL)animated {
    
    [self willDealloc];

    NSArray *vcArray =objc_getAssociatedObject(self, &key);
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:vcArray];
    if (tempArr.count > 0) {
        [tempArr removeLastObject];
    }
    vcArray = tempArr.copy;
    objc_setAssociatedObject(self, &key,vcArray,OBJC_ASSOCIATION_COPY);
    
    [self swizzledPopViewControllerAnimated:animated];
}

//push
- (void)swizzledPushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    NSArray *vcArray =objc_getAssociatedObject(self, &key);
    if (!vcArray) {
        vcArray = @[];
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:vcArray];
    [tempArr addObject:viewController];
    vcArray = tempArr.copy;
    objc_setAssociatedObject(self, &key,vcArray,OBJC_ASSOCIATION_COPY);

    [self swizzledPushViewController:viewController animated:animated];
}

- (BOOL)willDealloc {
    __weak UIViewController *weakVC = nil;
    
    NSMutableArray *vcArray =objc_getAssociatedObject(self, &key);
    if (vcArray && vcArray.count > 0) {
        UIViewController *vc = vcArray.lastObject;
        weakVC = vc;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakVC) {
            ADLog(@"vc - %@ do not dealloc",weakVC.title);
        }
    });
    return YES;
}

@end
