//
//  UIButton+CMButton.m
//  Coolest
//
//  Created by daoj on 2018/12/3.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import "UIButton+CMButton.h"
#import <objc/runtime.h>
#import "NSObject+SwizzledMethod.h"

static char CMActionTouchUpInsidesBlockKey;

static char CLNameKey;

@implementation UIButton (CMButton)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(mySendAction:to:forEvent:);

        
//        [self swizzledInstanceSEL:@selector(addTarget:action:forControlEvents:) withSEL:@selector(CL_AddTarget:action:forControlEvents:)];

        
        [self swizzledInstanceSEL:selA withSEL:selB];
        
    });
}
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


- (void)setNameId:(NSString *)nameId {
    objc_setAssociatedObject(self, &CLNameKey, nameId, OBJC_ASSOCIATION_COPY);
}

- (NSString *)nameId {
    
    NSString *nameStr = objc_getAssociatedObject(self, &CLNameKey);
    return nameStr;
}

- (void)CL_AddTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
    ADLog(@"----name - %@",[self nameId]);
    
    [self CL_AddTarget:target action:action forControlEvents:controlEvents];
}


- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
       
        ADLog(@"----name - %@",[self nameId]);
    }

    [self mySendAction:action to:target forEvent:event];

}
@end
