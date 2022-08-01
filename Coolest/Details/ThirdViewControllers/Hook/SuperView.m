//
//  SuperView.m
//  Coolest
//
//  Created by LiChuanmin on 2022/8/1.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "SuperView.h"
#import "NSObject+SwizzledMethod.h"

@implementation SuperView

+ (void)load {
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//
//        SEL selA = @selector(touchesBegan:withEvent:);
//        SEL selB = @selector(newTouchesBegan:withEvent:);
//
//        [self swizzledInstanceSEL:selA withSEL:selB];
//        
//    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ADLog(@"%s",__func__);
}

- (void)newTouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ADLog(@"--- %s",__func__);
}
@end
