//
//  UIButton+TestButtonC.m
//  Coolest
//
//  Created by LiChuanmin on 2022/6/1.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "UIButton+TestButtonC.h"

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@implementation UIButton (TestButtonC)

// 利用 **runtime** 设置

// 设置内边距范围,左右上下扩大范围一样
-(void)setEnLargeEdge:(CGFloat)size {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);

}

// 设置具体范围, 到上、右、下、左的距离
-(void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

// 重写点击范围事件
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect=[self enlargedRect];
    if(CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point);
}
// 重写响应范围bounds
-(CGRect)enlargedRect {
    NSNumber *topEdge=objc_getAssociatedObject(self, &topNameKey);
    NSNumber *rightEdge=objc_getAssociatedObject(self, &rightNameKey);
    NSNumber *bottomEdge=objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *leftEdge=objc_getAssociatedObject(self, &leftNameKey);
    
    if(topEdge && rightEdge && bottomEdge && leftEdge){
        return CGRectMake(self.bounds.origin.x-leftEdge.floatValue,
                          self.bounds.origin.y-topEdge.floatValue,
                          self.bounds.size.width+leftEdge.floatValue+rightEdge.floatValue,
                          self.bounds.size.height+topEdge.floatValue+bottomEdge.floatValue);
    }else{
        return self.bounds;
    }
}

@end
