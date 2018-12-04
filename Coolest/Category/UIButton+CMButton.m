//
//  UIButton+CMButton.m
//  Coolest
//
//  Created by daoj on 2018/12/3.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import "UIButton+CMButton.h"
#import <objc/runtime.h>

static char CMActionTouchUpInsidesBlockKey;

@implementation UIButton (CMButton)


- (void)addTargetSelected:(void(^)(UIButton *button))block {
    objc_setAssociatedObject(self, &CMActionTouchUpInsidesBlockKey, block, OBJC_ASSOCIATION_COPY);
    
    [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked:(UIButton *)button {
    void(^action)(UIButton *button) = objc_getAssociatedObject(self, &CMActionTouchUpInsidesBlockKey);
    
    if (action) {
        action(button);
    }
}

@end
