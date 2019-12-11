//
//  HitTestSubView.m
//  Coolest
//
//  Created by daoj on 2019/12/10.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "HitTestSubView.h"

@implementation HitTestSubView

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    ADLog(@" ------- point - %f-%f",point.x,point.y);
    
//    UIView *view = [super hitTest:point withEvent:event];
//    return view;
    
//    __block UIView *returnView = nil;
//    NSArray *subViews = self.subviews;
//    [subViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UIView *view = (UIView *)obj;
//        if ([view isKindOfClass:[UIButton class]] && CGRectContainsPoint(view.frame, point)) {
//            returnView = view;
//            *stop = YES;
//        }
//    }];
//    return returnView ? returnView : [super hitTest:point withEvent:event];
//}


@end
