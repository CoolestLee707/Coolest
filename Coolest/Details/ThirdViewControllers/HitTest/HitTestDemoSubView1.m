//
//  HitTestDemoSubView1.m
//  Coolest
//
//  Created by LiChuanmin on 2022/5/27.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "HitTestDemoSubView1.h"

@implementation HitTestDemoSubView1

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    ADLog(@"HitTestDemoSubView1 - hitTest");
    
//    self.view add v1,self.view add v2，重叠部分v1响应
//    if (point.y < 80) {
//        return nil;
//    }
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    ADLog(@"HitTestDemoSubView1 - pointInside");
    
//        self.view add v1,self.view add v2，重叠部分v1响应
//        if (point.y < 80) {
//            return NO;
//        }
    return [super pointInside:point withEvent:event];
}

@end
