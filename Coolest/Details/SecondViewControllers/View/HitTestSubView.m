//
//  HitTestSubView.m
//  Coolest
//
//  Created by daoj on 2019/12/10.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "HitTestSubView.h"

@implementation HitTestSubView
// 方法一：点击区域设置为圆形
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    ADLog(@"point   %f  %f",point.x,point.y);
    
    CGFloat x1 = point.x;
    CGFloat y1 = point.y;

    CGFloat x2 = self.frame.size.width / 2;
    CGFloat y2 = self.frame.size.height / 2;

    double dis = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
    // 67.923
    if (dis <= self.frame.size.width / 2) {
        ADLog(@"圆？");
        return self;
    }else {
        return self.superview;
    }
    
}

// 方法二：设置点击区域为圆形
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    CGFloat x1 = point.x;
//    CGFloat y1 = point.y;
//
//    CGFloat x2 = self.frame.size.width / 2;
//    CGFloat y2 = self.frame.size.height / 2;
//
//    double dis = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
//    // 67.923
//    if (dis <= self.frame.size.width / 2) {
//        return YES;
//    }
//    else{
//        return NO;
//    }
//}

@end
