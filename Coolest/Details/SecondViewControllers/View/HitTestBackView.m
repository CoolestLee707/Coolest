
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
#import "HitTestSubView.h"

@implementation HitTestBackView


/**
 走这个方法进去寻找、判断
 
 hitTest: withEvent: 是UIView 里面的一个方法，该方法的作用 在于 : 在视图的层次结构中寻找一个最适合的 view 来响应触摸事件，该方法会被系统调用，调用的时候，如果返回为nil，即事件有可能被丢弃，否则返回最合适的view 来响应事件

 
 -------------------------------这个方法返回合适的view，就不执行pointInside -------------------------------
 -------------------------------pointInside返回NO，就不继续找子view了 -------------------------------

 @param point 在接收器的局部坐标系(界)中指定的点
 @param event 系统保证调用此方法的事件。如果从事件处理代码外部调用此方法，则可以指定nil
 @return 视图对象是当前视图和包含点的最远的后代
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    ADLog(@" +++++ point - %f-%f",point.x,point.y);
    
//    UIView *view = [super hitTest:point withEvent:event];
//    return view;
    
    /*
    __block UIView *returnView = nil;
    NSArray *subViews = self.subviews;
    
//    找subview
    [subViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = (UIView *)obj;
        if ([view isKindOfClass:[UIView class]] && CGRectContainsPoint(view.frame, point)) {
            returnView = view;
            *stop = YES;
        }
    }];
   */
    
    
    
//    寻找最合适的响应view
//    --------------------------------------
    //  找button
    //最重要的是在同一坐标系判断
    //根据优先级判断
    //point当前坐标系的点位置
//    --------------------------------------

    UIView *returnView = nil;
    returnView = [self selectBestResponsViewWithPoint:point superView:self];
    return (returnView ? returnView : [super hitTest:point withEvent:event]);

}

//递归函数：自己实现查找步骤,不使用pointInside:withEvent:方法，自己通过坐标转换判断是否要响应，可以处理子视图超出父视图部分也能响应,使用系统的pointInside:withEvent:会把超出部分返回NO,不响应了
/// 选择最合适的响应的view
/// @param point 当前view中相应的点
/// @param superview 当前view
- (UIView *)selectBestResponsViewWithPoint:(CGPoint)point superView:(UIView *)superview {
    

//    -----------
    /*
    NSArray *subViews = superview.subviews;

    UIView *returnView = nil;
    if (CGRectContainsPoint(superview.bounds, point)) {
        returnView = superview;
    }
    
    if (subViews.count == 0) {
        return superview;
    }
    for (long i=subViews.count-1; i>=0; i--) {
        UIView *view = (UIView *)subViews[i];
        CGPoint viewPoint = [view convertPoint:point fromView:superview];
        
        if (CGRectContainsPoint(view.bounds, viewPoint)) {
            
            returnView = [self selectBestResponsViewWithPoint:viewPoint superView:view];
            break;
        }
    }
    
    return returnView;
    */
//    -----------
    
    //倒序遍历-NSEnumerationReverse
     __block UIView *returnView = nil;
     NSArray *subViews = superview.subviews;
    [subViews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIView *view = (UIView *)obj;
        CGPoint viewPoint = [view convertPoint:point fromView:superview];
        
        if (CGRectContainsPoint(view.bounds, viewPoint)) {
            
            if (view.subviews.count == 0) {
                 returnView = view;
            }else {
                returnView = [self selectBestResponsViewWithPoint:viewPoint superView:view];
            }
            *stop = YES;
            
        }else {
            
           if (view.subviews.count == 0) {
                returnView = nil;
           }else {
               returnView = [self selectBestResponsViewWithPoint:viewPoint superView:view];
           }
        }
        
    }];
   
    if (returnView == nil && CGRectContainsPoint(superview.bounds, point)) {
        returnView = superview;
    }
    return returnView;
   
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    return YES;
//}

- (void)dealloc
{
    
}
@end
