//
//  UIScrollView+ContentInset.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "UIScrollView+ContentInset.h"

@implementation UIScrollView (ContentInset)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        SEL originalSelector = @selector(setContentInset:);
        SEL swizzledSelector = @selector(Cool_SetContentInset:);
        
        Method originalMethod = class_getInstanceMethod(class,originalSelector);
        
        Method swizzledMethod = class_getInstanceMethod(class,swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
    });
}

- (void)Cool_SetContentInset:(UIEdgeInsets)contentInset
{
    
    [self Cool_SetContentInset:contentInset];
    
    //    关闭UIScrollViewContentInsetAdjustmentAutomatic
    if ([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]) {
        
        if (@available(iOS 11.0, *)) {
            self.scrollIndicatorInsets = self.contentInset;
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
}

@end
