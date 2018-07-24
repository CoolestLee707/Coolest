//
//  UIScrollView+ContentInset.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "UIScrollView+ContentInset.h"
#import "NSObject+SwizzledMethod.h"

@implementation UIScrollView (ContentInset)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzledInstanceSEL:@selector(setContentInset:) withSEL:@selector(Cool_SetContentInset:)];
        
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
