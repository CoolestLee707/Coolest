//
//  NSObject+SwizzledMethod.m
//  Coolest
//
//  Created by daoj on 2018/7/24.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "NSObject+SwizzledMethod.h"

@implementation NSObject (SwizzledMethod)

+ (void)swizzledInstanceSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL
{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);

    BOOL didAddMethod = class_addMethod(class, originalSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)swizzledClassSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL
{
    Class class = [self class];

//    通过object_getClass获取到的是类的元类
    
    Method originalMethod = class_getClassMethod(class, originalSEL);
    Method swizzledMethod = class_getClassMethod(class, swizzledSEL);
    
//    创建对象的类本身也是对象，称为类对象，类对象中存放的是描述实例相关的信息，例如实例的成员变量，实例方法。
//    类对象里的isa指针指向Subclass（meta），Subclass（meta）也是一个对象，是原类对象，原类对象中存放的是描述类相关的信息，例如类方法
//    给对象添加类方法，应该给它的metaClass进行添加，就像添加对象方法是给类添加
    
    Class metaClass = object_getClass(class);
    
    BOOL didAddMethod = class_addMethod(metaClass, originalSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(metaClass, swizzledSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
