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
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    ADLog(@"HitTestDemoSubView1 - pointInside");
    return [super pointInside:point withEvent:event];
}

@end
