//
//  HitTestButton.m
//  Coolest
//
//  Created by LiChuanmin on 2022/6/1.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "HitTestButton.h"

@implementation HitTestButton

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // 获取按钮当前大小
    CGRect btnBounds = self.bounds;
    // 扩大点击范围，正值为缩小，负值为扩大
    btnBounds = CGRectInset(btnBounds, -10, -10);
    
    // 返回新的bounds,在新的btnBounds里返回YES，否则返回NO
    return CGRectContainsPoint(btnBounds, point);
}

@end
