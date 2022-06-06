//
//  AssociatedPerson.m
//  Coolest
//
//  Created by LiChuanmin on 2022/5/16.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "AssociatedPerson.h"
#import <objc/runtime.h>

static char PersonKey;

@implementation AssociatedPerson

- (instancetype)init {
    ADLog(@"%s",__func__);
    return self;
}
- (void)setAss:(UIViewController *)vc {
    
    objc_setAssociatedObject(self, &PersonKey,vc,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)removeAss:(UIViewController *)vc {
    
    objc_removeAssociatedObjects(self);
}


- (void)dealloc {
    ADLog(@"%s",__func__);
}
@end
