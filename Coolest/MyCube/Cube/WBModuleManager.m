//
//  WBModuleManager.m
//  WBCube
//
//  Created by 金修博 on 2018/11/27.
//  Copyright © 2018 金修博. All rights reserved.
//

#import "WBModuleManager.h"
#import "WBModuleProtocol.h"
#import "WBCommon.h"
#import "WBContext.h"
#import <objc/runtime.h>
#import "WBTimeProfiler.h"

NSString * const kModDidFinishLaunchingEvent                        = @"modDidFinishLaunchingEvent:";
NSString * const kModWillResignActiveEvent                          = @"modWillResignActiveEvent:";
NSString * const kModDidBecomeActiveEvent                           = @"modDidBecomeActiveEvent:";
NSString * const kModWillEnterForegroundEvent                       = @"modWillEnterForegroundEvent:";
NSString * const kModDidEnterBackgroundEvent                        = @"modDidEnterBackgroundEvent:";
NSString * const kModWillTerminateEvent                             = @"modWillTerminateEvent:";
NSString * const kModDidReceiveMemoryWarningEvent                   = @"modDidReceiveMemoryWarningEvent:";
NSString * const kModDidRegisterForRemoteNotificationEvent          = @"modDidRegisterForRemoteNotificationEvent:";
NSString * const kModDidRegisterForRemoteNotificationEven           = @"modDidRegisterForRemoteNotificationEvent:";
NSString * const kModDidFailToRegisterForRemoteNotificationEvent    = @"modDidFailToRegisterForRemoteNotificationEvent:";
NSString * const kModDidReceiveRemoteNotificationEvent              = @"modDidReceiveRemoteNotificationEvent:";
NSString * const kModDidReceiveNotificationResponseEvent            = @"modDidReceiveNotificationResponseEvent:";
NSString * const kModDidReceiveLocalNotificationEvent               = @"modDidReceiveLocalNotificationEvent:";
NSString * const kModCustomEvent                                    = @"modCustomEvent:";
NSString * const kModSystemEvent                                    = @"modSystemEvent:";
NSString * const kModOpenURLEvent                                   = @"modOpenURLEvent:";
NSString * const kModInstallEvent                                   = @"modInstallEvent:";
NSString * const kModInitEvent                                      = @"modInitEvent:";
NSString * const kModUninstallEvent                                 = @"modUninstallEvent:";
NSString * const kModUserLoginSuccessEvent                          = @"modUserLoginSuccessEvent:";
NSString * const kModUserLoginFailEvent                             = @"modUserLoginFailEvent:";
NSString * const kModUserWillLogoutEvent                            = @"modUserWillLogoutEvent:";
NSString * const kModUserLogoutSuccessEvent                         = @"modUserLogoutSuccessEvent:";
NSString * const kModUserLogoutFailEvent                            = @"modUserLogoutFailEvent:";
NSString * const kModUserDeleteAccountDataEvent                     = @"modUserDeleteAccountDataEvent:";
NSString * const kModUserOffAccountEvent                            = @"modUserOffAccountEvent:";
NSString * const kModUserAbnormalSignoutEvent                       = @"modUserAbnormalSignoutEvent:";
NSString * const kModUserActiveEvent                                = @"modUserActiveEvent:";
NSString * const kModShortcutActionEvent                            = @"modShortcutActionEvent:";
NSString * const kModDidUpdateUserActivityEvent                     = @"modDidUpdateUserActivityEvent:";
NSString * const kModDidFailToContinueUserActivityEvent             = @"modDidFailToContinueUserActivityEvent:";
NSString * const kModContinueUserActivityEvent                      = @"modContinueUserActivityEvent:";
NSString * const kModWillContinueUserActivityEvent                  = @"modWillContinueUserActivityEvent:";
NSString * const kModHandleWatchKitExtensionRequestEvent            = @"modHandleWatchKitExtensionRequestEvent:";
NSString * const kModHomePageWillAppearEvent                        = @"modHomePageWillAppearEvent:";
NSString * const kModHomePageDidAppearEvent                         = @"modHomePageDidAppearEvent:";
NSString * const kModHomePageViewDidLoadEvent                       = @"modHomePageViewDidLoadEvent:";
NSString * const kModTabbarItemClickEvent                           = @"modTabbarItemClickEvent:";

@interface WBModuleManager ()
// 所有模块
@property(nonatomic, strong) NSMutableArray *modules;
// 所有协议方法
@property(nonatomic, strong) NSMutableSet *selectorByEvent;
// [协议方法：[实现这个方法的所有module] ]
@property(nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<id<WBModuleProtocol>> *> *modulesByEvent;
@end

@implementation WBModuleManager

+ (instancetype)shareInstance {
    static WBModuleManager *manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        //...
    }
    return self;
}

- (void)registerModule:(Class)moduleClass {
    if (!moduleClass) return;
    
    if ([moduleClass conformsToProtocol:@protocol(WBModuleProtocol)]) {
        //实例化
        id<WBModuleProtocol> moduleInstance = [[moduleClass alloc] init];
        [self.modules addObject:moduleInstance];
        
        MagicLog(@">>>>>>>>>> %@ 模块动态注册完成.", NSStringFromClass(moduleClass));
        
        //注册事件-模块映射表
        [self registerEventWithModuleInstance:moduleInstance];
    } else {
        MagicLog(@">>>>>>>>>> WBCubeError:[%@] 没有实现WBModuleProtocol协议", NSStringFromClass(moduleClass));
    }
}

- (void)registerEventWithModuleInstance:(id<WBModuleProtocol>)moduleInstance {
    NSArray<NSString *> *events = self.selectorByEvent.allObjects;

    //遍历所有事件,创建事件-模块映射关系
    [events enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerEvent:obj withModuleInstance:moduleInstance];
    }];
}

- (void)registerEvent:(NSString *)event withModuleInstance:(id<WBModuleProtocol>)moduleInstance {
    NSParameterAssert(event);
    if (!event) return;
    SEL selector = NSSelectorFromString(event);
    if(!selector) return;

    if (![self.selectorByEvent containsObject:event]) {
        //如果eventType类型不存在就添加到事件字典中,为的是扩充自定义事件类型
        [self.selectorByEvent addObject:event];
    }
    if (!self.modulesByEvent[event]) {
        [self.modulesByEvent setObject:@[].mutableCopy forKey:event];
    }
    NSMutableArray *modulesOfEvent = [self.modulesByEvent objectForKey:event];

    if (![modulesOfEvent containsObject:moduleInstance] && [moduleInstance respondsToSelector:selector]) {
        [modulesOfEvent addObject:moduleInstance];

        [modulesOfEvent sortUsingComparator:^NSComparisonResult(id<WBModuleProtocol> module1, id<WBModuleProtocol> module2) {
            NSInteger module1Priority = 0;
            NSInteger module2Priority = 0;
            if ([module1 respondsToSelector:@selector(priority)]) {
                module1Priority = [module1 priority];
            }
            if ([module2 respondsToSelector:@selector(priority)]) {
                module2Priority = [module2 priority];
            }
            return module1Priority < module2Priority;
        }];
    }
}


- (void)unregisterModuleWithModule:(Class)moduleClass {
    if (!moduleClass) return;
    
    //modules删除moduleClass对应的module
    __block NSInteger index = -1;
    [self.modules enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:moduleClass]) {
            index = idx;
            *stop = YES;
        }
    }];
    
    if (index >= 0) {
        [self.modules removeObjectAtIndex:index];
    }
    
    //模块-事件映射表删除moduleClass对应的module
    [self.modulesByEvent enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableArray<id<WBModuleProtocol>> * _Nonnull obj, BOOL * _Nonnull stop) {
        __block NSInteger index = -1;
        
        [obj enumerateObjectsUsingBlock:^(id<WBModuleProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:moduleClass]) {
                index = idx;
                *stop = YES;
            }
        }];
        
        if (index >= 0) {
            [obj removeObjectAtIndex:index];
        }
    }];
}

- (void)registerCustomEvent:(NSString *)event withModuleInstance:(id<WBModuleProtocol>)moduleInstance {
    [self registerEvent:event withModuleInstance:moduleInstance];
}

#pragma mark - 触发事件
- (void)triggerEvent:(NSString *)event {
    [self triggerEvent:event customParam:nil];
}

#pragma mark - 触发事件(携带自定义参数)
- (void)triggerEvent:(NSString *)event customParam:(NSDictionary *)customParam {
    [self triggerModuleEvent:event withTarget:nil withCustomParam:customParam];
}

- (void)triggerModuleEvent:(NSString *)event
                withTarget:(id<WBModuleProtocol>)target
           withCustomParam:(NSDictionary *)customParam {
    
    if ([event isEqualToString:kModInstallEvent]) {
        [self triggerModuleInstallEventWithTarget:target withCustomParam:customParam];
    }else if ([event isEqualToString:kModInitEvent]) {
        [self triggerModuleInitEventWithTarget:target withCustomParam:customParam];
    } else if ([event isEqualToString:kModUninstallEvent]) {
        [self triggerModuleUninstallEventWithTarget:target withCustomParam:customParam];
    } else {
        [self triggerModuleCommonEvent:event withTarget:target withCustomParam:customParam];
    }
}

#pragma mark --- 安装模块
- (void)triggerModuleInstallEventWithTarget:(id<WBModuleProtocol>)target withCustomParam:(NSDictionary *)customParam {
    //根据优先级排序
    [self.modules sortUsingComparator:^NSComparisonResult(id<WBModuleProtocol> module1, id<WBModuleProtocol> module2) {
        NSInteger module1Priority = 0;
        NSInteger module2Priority = 0;
        if ([module1 respondsToSelector:@selector(priority)]) {
            module1Priority = [module1 priority];
        }
        if ([module2 respondsToSelector:@selector(priority)]) {
            module2Priority = [module2 priority];
        }
        return module1Priority < module2Priority;
    }];
    
    NSArray<id<WBModuleProtocol>> *moduleInstances;
    if (target) {
        moduleInstances = @[target];
    }else{
        moduleInstances = [self.modulesByEvent objectForKey:kModInstallEvent];
    }
    
    WBContext *context = [WBContext shareInstance].copy;
    context.customEvent = kModInstallEvent;
    context.customParam = customParam;
    
    [moduleInstances enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<WBModuleProtocol>  _Nonnull moduleInstance, NSUInteger idx, BOOL * _Nonnull stop) {
        if (moduleInstance && [moduleInstance respondsToSelector:@selector(modInstallEvent:)]) {
            [moduleInstance modInstallEvent:context];
            MagicLog(@">>>>>>>>>> %@ 模块装载完成. <<<<<<<<<<", moduleInstance);
            [[WBTimeProfiler sharedTimeProfiler] recordEventTime:[NSString stringWithFormat:@">>>>>>>>>> %@ 模块装载（modInstallEvent） <<<<<<<<<<", [moduleInstance class]]];
        }
    }];

//    [self triggerModuleCommonEvent:kModInstallEvent withTarget:target withCustomParam:customParam];
}

- (void)triggerModuleInitEventWithTarget:(id<WBModuleProtocol>)target withCustomParam:(NSDictionary *)customParam {
    NSArray<id<WBModuleProtocol>> *moduleInstances;
    if (target) {
        moduleInstances = @[target];
    }else{
        moduleInstances = [self.modulesByEvent objectForKey:kModInitEvent];
    }
    
    WBContext *context = [WBContext shareInstance].copy;
    context.customEvent = kModInitEvent;
    context.customParam = customParam;
    
    [moduleInstances enumerateObjectsUsingBlock:^(id<WBModuleProtocol>  _Nonnull moduleInstance, NSUInteger idx, BOOL * _Nonnull stop) {
        __weak typeof(self) weakSelf = self;
        void (^callback)(void);
        callback = ^(){
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                if ([moduleInstance respondsToSelector:@selector(modInitEvent:)]) {
                    MagicLog(@">>>>>>>>>> %@ 模块开始初始化... <<<<<<<<<<", moduleInstance.class);
                    [moduleInstance modInitEvent:context];
                    MagicLog(@">>>>>>>>>> %@ 模块初始化完成. <<<<<<<<<<", moduleInstance.class);
                }
            }
        };
        
        [[WBTimeProfiler sharedTimeProfiler] recordEventTime:[NSString stringWithFormat:@">>>>>>>>>> %@ 模块初始化（modInitEvent） <<<<<<<<<<", [moduleInstance class]]];
       
        if ([moduleInstance respondsToSelector:@selector(async)]) {
            BOOL async = [moduleInstance async];
            
            if (async) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback();
                });
            }else{
                callback();
            }
        }else{
            callback();
        }
    }];
}

- (void)triggerModuleUninstallEventWithTarget:(id<WBModuleProtocol>)target withCustomParam:(NSDictionary *)customParam {
    NSArray<id<WBModuleProtocol>> *moduleInstances;
    if (target) {
        moduleInstances = @[target];
    }else{
        moduleInstances = [self.modulesByEvent objectForKey:kModUninstallEvent];
    }
    
    WBContext *context = [WBContext shareInstance].copy;
    context.customEvent = kModUninstallEvent;
    context.customParam = customParam;
    
    [moduleInstances enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<WBModuleProtocol>  _Nonnull moduleInstance, NSUInteger idx, BOOL * _Nonnull stop) {
        if (moduleInstance && [moduleInstance respondsToSelector:@selector(modUninstallEvent:)]) {
            [moduleInstance modUninstallEvent:context];
        }
    }];
}

- (void)triggerModuleCommonEvent:(NSString *)eventType
                      withTarget:(id<WBModuleProtocol>)target
                 withCustomParam:(NSDictionary *)customParam {
    if (!eventType) return;
    if (![self.selectorByEvent containsObject:eventType]) return;
    SEL selector = NSSelectorFromString(eventType);
    NSArray<id<WBModuleProtocol>> *moduleInstances;
    if (target) {
        moduleInstances = @[target];
    }else{
        moduleInstances = [self.modulesByEvent objectForKey:eventType];
    }
    
    WBContext *context = [WBContext shareInstance].copy;
    context.customEvent = eventType;
    context.customParam = customParam;
    
    [moduleInstances enumerateObjectsUsingBlock:^(id<WBModuleProtocol>  _Nonnull moduleInstance, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([moduleInstance respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [moduleInstance performSelector:selector withObject:context];
#pragma clang diagnostic pop
            [[WBTimeProfiler sharedTimeProfiler] recordEventTime:[NSString stringWithFormat:@">>>>>>>>>> %@ 模块自定义（%@） <<<<<<<<<<", [moduleInstance class], NSStringFromSelector(selector)]];
        }
    }];
}


#pragma mark - property getter
- (NSMutableArray *)modules {
    if (!_modules) {
        _modules = [NSMutableArray array];
    }
    return _modules;
}

- (NSMutableDictionary<NSString *,NSMutableArray<id<WBModuleProtocol>> *> *)modulesByEvent {
    if (!_modulesByEvent) {
        _modulesByEvent = [NSMutableDictionary dictionary];
    }
    return _modulesByEvent;
}

- (NSMutableSet *)selectorByEvent {
    if (!_selectorByEvent) {
        _selectorByEvent = [NSMutableSet set];
        NSSet *blackSelList = [NSSet setWithObjects:@"priority", @"async", nil];
        
        unsigned int numberOfMethods = 0;
        struct objc_method_description *methodDescriptions = protocol_copyMethodDescriptionList(@protocol(WBModuleProtocol), NO, YES, &numberOfMethods);
        for (unsigned int i = 0; i < numberOfMethods; ++i) {
            struct objc_method_description methodDescription = methodDescriptions[i];
            SEL selector = methodDescription.name;
            if (! class_getInstanceMethod([self class], selector)) {
                NSString *selectorString = [NSString stringWithCString:sel_getName(selector) encoding:NSUTF8StringEncoding];
                if (![blackSelList containsObject:selectorString]) {
                    [_selectorByEvent addObject:selectorString];
                }
            }
        }
    }
    return _selectorByEvent;
}


@end
