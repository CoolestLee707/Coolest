
//
//  HitTestBackView.m
//  Coolest
//
//  Created by daoj on 2018/8/10.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

//如果一个子视图的区域超过父视图的区域(父视图的clipsToBounds属性为NO)，一般情况下在父视图区域外的触摸操作不会被识别,因为父视图的pointInside:withEvent:方法会返回NO,这样就不会继续向下遍历子视图了。当然也可以重写pointInside:withEvent:方法来处理这种问题

//hitTest 的调用顺序
//touch -> UIApplication -> UIWindow -> UIViewController.view -> subViews -> ....-> 合适的view


#import "HitTestBackView.h"

@implementation HitTestBackView


/**
 hitTest: withEvent: 是UIView 里面的一个方法，该方法的作用 在于 : 在视图的层次结构中寻找一个最适合的 view 来响应触摸事件，该方法会被系统调用，调用的时候，如果返回为nil，即事件有可能被丢弃，否则返回最合适的view 来响应事件

 @param point 在接收器的局部坐标系(界)中指定的点
 @param event 系统保证调用此方法的事件。如果从事件处理代码外部调用此方法，则可以指定nil
 @return 视图对象是当前视图和包含点的最远的后代
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    ADLog(@" point - %f-%f",point.x,point.y);
    
//    UIView *view = [super hitTest:point withEvent:event];
//    return view;
    
    __block UIView *returnView = nil;
    NSArray *subViews = self.subviews;
    [subViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = (UIView *)obj;
        if ([view isKindOfClass:[UIButton class]] && CGRectContainsPoint(view.frame, point)) {
            returnView = view;
            *stop = YES;
        }
    }];
    return returnView ? : [super hitTest:point withEvent:event];
}
- (void)dealloc
{
    
}
@end
