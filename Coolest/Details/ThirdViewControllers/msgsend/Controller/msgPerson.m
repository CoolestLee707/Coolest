//
//  msgPerson.m
//  Coolest
//
//  Created by daoj on 2018/11/29.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import "msgPerson.h"
#import <objc/runtime.h>
#import "msgDog.h"

@implementation msgPerson

- (void)run
{
    ADLog(@"running------");
}

#pragma mark -- 第一阶段：动态方法解析

//当类调用一个没有实现的 对象方法 就会到这里
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
//    NSString *methodName = NSStringFromSelector(sel);
//    ADLog(@"methodName - %@",methodName);
//    if ([methodName isEqualToString:@"sendMessageInstance:"]) {
//
//    }
    
    if (sel == @selector(sendMessageInstance:)) {
        
        /**
         动态添加方法

         @param self 给哪个类添加方法,self/[self class]
         @param sel 添加方法的方法编号
         @param IMP 添加方法的函数实现（函数地址）C ->(IMP)sendMessage,OC->class_getMethodImplementation
         @return 函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
         
         "v@:"
         "v@:@"
         */
        
//        sel 有了，没有方法实现IMP和types
        
//        添加C函数
//        return class_addMethod(self, sel, (IMP)sendMessageOfC, "v@:@");
        
//         添加OC方法--1，根据要添加的方法的sel找IMP
//        return class_addMethod([self class], sel, class_getMethodImplementation(self, @selector(sendMessageOfOC:)), "v@:@");
        
//        添加OC方法--2，根据要添加的方法的sel找到Method，再根据Method找到IMP
//        Method method = class_getInstanceMethod(self, @selector(sendMessageOfOC:));
        
//        return class_addMethod(self, sel, method_getImplementation(method), method_getTypeEncoding(method));
        
    }
    
    return [super resolveInstanceMethod:sel];
}


//当类调用一个没有实现的 类方法 就会到这里！！
+ (BOOL)resolveClassMethod:(SEL)sel {
    
//    ADLog(@"%@",NSStringFromSelector(sel));
////    获取metaClass
//    Class metaClass = objc_getMetaClass(class_getName(self));
//    Class metaClass = objc_getClass(self);

//    Class metaClass = objc_getMetaClass([NSStringFromClass(self) UTF8String]);
//
//    if (sel == @selector(sendMessageClass:)) {
//
//        return  class_addMethod(metaClass, sel, (IMP)classEatOfC, "v@:");
//    }

    return [super resolveClassMethod:sel];
}





#pragma mark -- 第二阶段：进行消息转发

#pragma mark  一、找备用的接受者

//实例
- (id)forwardingTargetForSelector:(SEL)aSelector
{
//    NSString *methodName = NSStringFromSelector(aSelector);
//    ADLog(@"methodName - %@",methodName);
//
//    if ([methodName isEqualToString:@"sendMessageInstance:"]) {
//
//        msgDog *dog = [msgDog new];
//        if ([dog respondsToSelector:aSelector]) {
//            return dog;
//        }
//    }
    return [super forwardingTargetForSelector:aSelector];
}

//类
+ (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSString *methodName = NSStringFromSelector(aSelector);
    ADLog(@"methodName - %@",methodName);
    if ([methodName isEqualToString:@"sendMessageClass:"]) {
        
//         也可在此转发实例方法
//        msgDog *dog = [msgDog new];
//        if ([dog respondsToSelector:aSelector]) {
//            return dog;
//        }
        
        
//         也可在此转发实例方法
//        return [msgDog class];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark  二、消息转发
//签名返回为空不会forwardInvocation
//1、方法签名--实例
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
//    ADLog(@"method signature for selector: %@",NSStringFromSelector(aSelector));

    if (aSelector == @selector(sendMessageInstance:)) {
        
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

//1、方法签名--类
+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
//    找出对应的 aSelector 签名
     NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
//     也可以在此获取实例方法的签名,对应实例的消息转发和未知错误--（注意！！！）
//    if (signature == nil) {
//    //是否有 aSelector
//        if ([msgDog instancesRespondToSelector:aSelector]) {
//            signature = [msgDog instanceMethodSignatureForSelector:aSelector];
//        }
//    }
    
    
    //instanceMethodSignatureForSelector只能获取实例方法的签名
    //methodSignatureForSelector 可以获取类方法和实例方法的签名

    
    if (signature == nil) {
//        是否有 aSelector
        if ([msgDog respondsToSelector:aSelector]) {
            signature = [msgDog methodSignatureForSelector:aSelector];
        }
    }
    
     return signature;
}


//2、消息转发
//NSInvocation封装了一个方法调用
//
//anInvocation.target   以前的方法调用者
//anInvocation.selector 方法名
//[anInvocation getArgument:NULL atIndex:0];    方法参数

-(void)forwardInvocation:(NSInvocation *)anInvocation {
    
   
//    ADLog(@"forwardInvocation: %@",NSStringFromSelector([anInvocation selector]));
    
    SEL sel = [anInvocation selector];
    
    if (sel == @selector(sendMessageInstance:)) {
        
        msgDog *dog = [msgDog new];
        
//        anInvocation.target = dog;
//        [anInvocation invoke];

        if ([dog respondsToSelector:sel]) {
            
            [anInvocation invokeWithTarget:dog];
        }
    }else {
        [super forwardInvocation:anInvocation];
    }
}


+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    

    if ([msgDog instancesRespondToSelector:anInvocation.selector]) {
        
//        也可以调用实例方法，对应实例的签名和未知错误--（注意！！！）

//        msgDog *dog = [msgDog new];
//        [anInvocation invokeWithTarget:dog];
        
        [anInvocation invokeWithTarget:[msgDog class]];
    }else {
        [super forwardInvocation:anInvocation];
    }
}
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    
    ADLog(@"未知错误:%@",NSStringFromSelector(aSelector));
}

+ (void)doesNotRecognizeSelector:(SEL)aSelector {
    
    ADLog(@"未知错误:%@",NSStringFromSelector(aSelector));
}

#pragma mark -- 动态添加的方法
//C
void sendMessageOfC(id self, SEL _cmd, NSString *msg) {

    ADLog(@"动态添加的方法-带参数-C- %@",msg);
}

void classEatOfC(id self,SEL sel) {
    
    ADLog(@"动态添加的方法-不带参数-C-");
}



//OC
- (void)sendMessageOfOC:(NSString *)ocStr {
    ADLog(@"动态添加的方法-带参数-OC- %@",ocStr);
}

- (void)sendMessageOfOCNoParameter {
    ADLog(@"动态添加的方法-不带参数-OC");
}

@end
