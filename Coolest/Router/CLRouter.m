//
//  CLRouter.m
//  Coolest
//
//  Created by LiChuanmin on 2020/9/28.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "CLRouter.h"

@implementation CLRouter

+ (instancetype)sharedInstance
{
    static CLRouter *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[CLRouter alloc] init];
    });
    return mediator;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget
{
    if (targetName == nil || actionName == nil) {
        return nil;
    }
    
    
    
    
    if ([targetName isEqualToString:@"KVOViewController"]) {
        
        Class targetClass = NSClassFromString(targetName);
        UIViewController *target = (UIViewController *)[[targetClass alloc] init];
        UIApplication *app = [UIApplication sharedApplication];
        UITabBarController *tab = (UITabBarController *)app.delegate.window.rootViewController;
        UINavigationController *nav = (UINavigationController *)[tab selectedViewController];
        [nav pushViewController:target animated:YES];
        return nil;
    }
    
    
    Class targetClass = NSClassFromString(targetName);
    SEL action = NSSelectorFromString(actionName);

    NSObject *target = [[targetClass alloc] init];
    
    NSMethodSignature* methodSig = [target methodSignatureForSelector:action];

    if(methodSig == nil) {
        return nil;
    }
    
//    const char* retType = [methodSig methodReturnType];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
//    [invocation setArgument:&params atIndex:2];
    NSString *name = [params objectForKey:@"key"];
    NSString *age = @"10";
    [invocation setArgument:&name atIndex:2];
    [invocation setArgument:&age atIndex:3];

    [invocation setSelector:action];
    [invocation setTarget:target];
    [invocation invoke];
    return nil;

    
    
}
@end
