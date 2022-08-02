//
//  HitTestDemoView.m
//  Coolest
//
//  Created by LiChuanmin on 2022/5/27.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "HitTestDemoView.h"

@implementation HitTestDemoView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    ADLog(@"HitTestDemoView - hitTest");
    
//    可以直接返回self，阻断事件继续传递查找（v1 add v2）
//    if (CGRectContainsPoint(self.bounds, point)) {
//        return self;
//    }
    
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    ADLog(@"HitTestDemoView - pointInside");
    return [super pointInside:point withEvent:event];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ADLog(@"touchesBegan - withEvent");
}
@end

// hitTest: withEvent: 是UIView 里面的一个方法，该方法的作用 在于 : 在视图的层次结构中寻找一个最适合的 view 来响应触摸事件，该方法会被系统调用，调用的时候，如果返回为nil，即事件有可能被丢弃，否则返回最合适的view 来响应事件
//-------------------------------这个方法返回合适的view，就不执行pointInside -------------------------------
//-------------------------------pointInside返回NO，就不继续找子view了 -------------------------------

//  hitTest: withEvent: --> if(self.userInterfactionEnabled == NO || self.alpla < 0.05 || self.hidden == YES ) {return nil} else { pointInside: withEvent: ->YES : 倒序遍历子视图，继续这个过程，递归 :NO return self}
