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

//    其中四个参数分别是：要添加方法的类、方法的名字、方法的实现和方法的参数。返回一个BOOL值，如果类中已经存在该方法，则返回NO，如果类中不存在该方法，则返回YES。
    BOOL didAddMethod = class_addMethod(class, originalSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    
//    至于为什么要先用class_addMethod方法做一次判断，是因为我们要替换的方法有可能并没有在这个类中被实现，而是在他的父类中实现的，这个时候originSEL获取到的方法就是他父类中的方法。所以我们要在当前的类中添加一个originSEL方法，但是用destSEL也就是我们自己方法的实现去实现它。然后再把父类方法的实现替换给我们自己的方法。这样就将originSEL和destSEL的实现进行了交换。
//    先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
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
