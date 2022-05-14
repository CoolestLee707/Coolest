//
//  WBRouter.m
//  WBCube
//
//  Created by 金修博 on 2018/6/18.
//  Copyright © 2018年 金修博. All rights reserved.
//

#import "WBRouter.h"
#import <objc/runtime.h>
#import "WBServiceManager.h"
#import "WBRouter+WBExtension.h"

#pragma mark - >>> Global Area
static NSString *const WBURLFragmentViewControlerEnterModePush = @"push";
static NSString *const WBURLFragmentViewControlerEnterModeModal = @"modal";

typedef NS_ENUM(NSUInteger, WBUseMode) {
    WBUseModeUnknown,       //未知类型
    WBUseModeCallService,   //通过协议调用
    WBUseModeTargetAction   //通过Target-Action调用
};

typedef NS_ENUM(NSUInteger, WBRouterViewControlerEnterMode) {
    WBRouterViewControlerEnterModeUnknown,   //未知类型(不进行跳转，只获取return object)
    WBRouterViewControlerEnterModePush,      //push操作
    WBRouterViewControlerEnterModeModal      //modal操作
};

#pragma mark - WBRouter

@interface WBRouter()

@property (nonatomic, strong) NSMutableDictionary *cachedService;

@end

@implementation WBRouter

#pragma mark - 全局访问点
+ (instancetype)sharedInstance {
    static WBRouter *router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[WBRouter alloc] init];
        [router cachedService];
    });
    
    return router;
}

#pragma mark - Public Method - OpenURL
+ (BOOL)canOpenURL:(NSURL *)URL {
    if (!URL) {
        return NO;
    }
    
    NSString *scheme = URL.scheme;
    if (!scheme.length) {
        return NO;
    }
    
    NSString *host = URL.host;
    if (!host.length) {
        return NO;
    }
    
    __block BOOL flag = YES;
    
    // 优先查找Class
    NSString *modName = [WBRouter.sharedInstance.serviceMap valueForKey:host];
    NSString *targetClsStr = nil;
    // Swift
    if (modName) {
       targetClsStr = [NSString stringWithFormat:@"%@.Service_%@", modName, host];
    }
    // Objc
    else {
       targetClsStr = [NSString stringWithFormat:@"Service_%@", host];
    }
    
    Class mClass = NSClassFromString(targetClsStr);
    
    // selector
    NSArray<NSString *> *pathComponents = URL.pathComponents;
    
    __block NSString *selectorStr;
    
    [pathComponents enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:@"/"]) {
            selectorStr = obj;
        }
    }];
    
    // Class不存在查找协议
    if (!mClass) {
        Protocol *protocol = NSProtocolFromString(host);
        if (protocol) {
            Class implClass = [[WBServiceManager sharedManager] implClassForService:protocol];
            if (!implClass) {
                flag = NO;
            } else {
                flag = YES;
            }
        } else {
            flag = NO;
        }
    } else {
        if (selectorStr) {
            selectorStr = [NSString stringWithFormat:@"action_%@:",selectorStr];
            SEL selector = NSSelectorFromString(selectorStr);
            
            id instance = [[mClass alloc] init];
            if (![instance respondsToSelector:selector]) {
                flag = NO;
            } else {
                flag = YES;
            }
        } else {
            flag = NO;
        }
    }
    
    return flag;
}

+ (BOOL)openURL:(NSURL *)URL {
    return [self openURL:URL withParams:nil customHandler:nil];
}

+ (BOOL)openURL:(NSURL *)URL withParams:(NSDictionary<NSString *, NSString *> *)params {
    return [self openURL:URL withParams:params customHandler:nil];
}

+ (BOOL)openURL:(NSURL *)URL
     withParams:(NSDictionary<NSString *, NSString *> *)params
  customHandler:(void(^)(NSString *pathComponentKey, id obj, id returnValue))customHandler {
    
    if (![self canOpenURL:URL]) {
#if DEBUG
        NSString *errMsg = [NSString stringWithFormat:@"[%@]未能正常打开,请检查target-action是否有效.",URL.absoluteString];
        [self addressingErrorAlertWithToast:errMsg];
#endif
        return NO;
    }
    
    // NSString *scheme = URL.scheme;
    NSString *host = URL.host;
    WBUseMode useMode = [self usage:host];
    
    WBRouterViewControlerEnterMode enterMode = WBRouterViewControlerEnterModeUnknown;
    if (URL.fragment.length) {
        enterMode = [self viewControllerEnterMode:URL.fragment];
    }
    
    // parameters
    NSDictionary<NSString *, NSString *> *queryDic = [self queryParameterFromURL:URL];
    
    // selectorStr
    __block NSString *selectorStr;
    NSArray<NSString *> *pathComponents = URL.pathComponents;
    [pathComponents enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:@"/"]) {
            selectorStr = obj;
        }
    }];
    
    id returnValue;
    id obj;
    NSString *pathComponentKey;
    
    switch (useMode) {
        // 通过协议调用
        case WBUseModeCallService: {
            Protocol *protocol = NSProtocolFromString(host);
            selectorStr = [NSString stringWithFormat:@"action_%@:", selectorStr];
            SEL selector = NSSelectorFromString(selectorStr);
            obj = [[WBServiceManager sharedManager] createService:protocol];
            
            Class mClass = [[WBServiceManager sharedManager] implClassForService:protocol];
            NSDictionary<NSString *, id> *finalParams = [self solveURLParams:queryDic withFuncParams:params forClass:mClass];
            
            // pathComponentKey
            NSString *classStr = NSStringFromClass(mClass);
            pathComponentKey = [NSString stringWithFormat:@"%@.%@",classStr,selectorStr];
            
            returnValue = [self safePerformAction:selector target:obj params:finalParams];
            
            if (enterMode == WBRouterViewControlerEnterModePush || enterMode == WBRouterViewControlerEnterModeModal) {
                [self solveJumpWithViewController:(UIViewController *)obj andJumpMode:enterMode shouldAnimate:YES];
            }
        }
            break;
        // 通过Target-Action调用
        case WBUseModeTargetAction: {
            NSString *modName = [WBRouter.sharedInstance.serviceMap valueForKey:host];
            NSString *targetClsStr = nil;
            
            // Swift
            if (modName) {
                targetClsStr = [NSString stringWithFormat:@"%@.Service_%@", modName, host];
            }
            // Objc
            else {
                targetClsStr = [NSString stringWithFormat:@"Service_%@", host];
            }
            
            Class mClass = NSClassFromString(targetClsStr);;
            selectorStr = [NSString stringWithFormat:@"action_%@:", selectorStr];
            SEL selector = NSSelectorFromString(selectorStr);
            id instance = [[mClass alloc] init];
            
            NSDictionary<NSString *, id> *finalParams = [self solveURLParams:queryDic withFuncParams:params forClass:mClass];
            returnValue = [self safePerformAction:selector target:instance params:finalParams];
            pathComponentKey = [NSString stringWithFormat:@"%@.%@",targetClsStr,selectorStr];
            
            if (enterMode == WBRouterViewControlerEnterModePush || enterMode == WBRouterViewControlerEnterModeModal) {
                [self solveJumpWithViewController:(UIViewController *)returnValue andJumpMode:enterMode shouldAnimate:YES];
            }
        }
            break;
        default:
            break;
    }
    
    !customHandler ?: customHandler(pathComponentKey, obj, returnValue);
    return YES;
}

#pragma mark - Public Method - 获取&注册服务
+ (id)createService:(Protocol *)protocol {
    return [[WBServiceManager sharedManager] createService:protocol];
}

+ (void)registerService:(Protocol *)proto service:(Class)serviceClass {
    [[WBServiceManager sharedManager] registerService:proto implClass:serviceClass];
}

+ (void)registerServiceWithPlistNames:(NSString *)plistName, ... {
    va_list va_arguments;
    va_start(va_arguments, plistName);
    NSArray *arguments = WBRouterUtils.transformVariadicArgsToArray(va_arguments);
    
    if (plistName) {
        NSMutableArray *plistMarr = [NSMutableArray arrayWithObject:plistName];
        [plistMarr addObjectsFromArray:arguments];
        
        [plistMarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                [[WBServiceManager sharedManager] registerLocalServices:(NSString *)obj];
            }
        }];
    }
    
    va_end(va_arguments);
}

+ (NSDictionary *)allServices {
    return [[WBServiceManager sharedManager] allServices];
}

#pragma mark - Public Method - Target-Action
+ (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params {
    if (targetName == nil || actionName == nil) {
        return nil;
    }
    
    NSString *modName = [WBRouter.sharedInstance.serviceMap valueForKey:targetName];
    NSString *targetClsStr = nil;
    // Swift
//    在swift中使用时，需要传入对应项目的target名称
    if (modName) {
        targetClsStr = [NSString stringWithFormat:@"%@.Service_%@", modName, targetName];
    }
    // Objc
    else {
        targetClsStr = [NSString stringWithFormat:@"Service_%@", targetName];
    }
    
    NSObject *target = [WBRouter.sharedInstance safeFetchCachedService:targetClsStr];
    if (target == nil) {
        Class targetClass = NSClassFromString(targetClsStr);
        target = [[targetClass alloc] init];
    }
    
    NSString *actionString = [NSString stringWithFormat:@"action_%@:", actionName];
    
    if (target == nil) {
        [self NoTargetActionResponseWithTarget:targetName action:nil params:params];
        return nil;
    }
    
    SEL action = NSSelectorFromString(actionString);
    if ([target respondsToSelector:action]) {
        [WBRouter.sharedInstance safeSetCachedService:target key:targetClsStr];
        return [self safePerformAction:action target:target params:params];
    } else {
        [self NoTargetActionResponseWithTarget:targetName action:actionName params:params];
        return nil;
    }
}

+ (void)NoTargetActionResponseWithTarget:(NSString *)target action:(NSString *)action params:(NSDictionary *)params {
#if DEBUG
    NSString *message = @"";
    if (action) {
        message = [NSString stringWithFormat:@"服务 %@ 中不存在 %@ 接口！！", target, action];
    } else {
        message = [NSString stringWithFormat:@"服务 %@ 接口，不存在！！", target];
    }
    [self addressingErrorAlertWithToast:message];
#endif
    
    // 低版本不支持router方法时，提供默认异常回调
    void (^failCallBack)(NSDictionary *result) = [params objectForKey:@"fail"];
    !failCallBack ?: failCallBack(@{@"code": @(-10001), @"message": @"当前版本不支持此方法!!", @"detail": @"未找到目标服务!!"});
}

+ (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params {

    NSMethodSignature* methodSig = [target methodSignatureForSelector:action];
    if(methodSig == nil) {
        return nil;
    }
    const char* retType = [methodSig methodReturnType];

    if (strcmp(retType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        return nil;
    }

    if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(retType, @encode(BOOL)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(retType, @encode(CGFloat)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}

#pragma mark - Private Method
///根据URL分解出参数
+ (NSDictionary<NSString *, id> *)queryParameterFromURL:(NSURL *)URL {
    if (!URL) {
        return nil;
    }
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:NO];
    
    NSArray <NSURLQueryItem *> *queryItems = [components queryItems] ?: @[];
    
    NSMutableDictionary *queryParams = @{}.mutableCopy;
    
    for (NSURLQueryItem *item in queryItems) {
        if (item.value == nil) {
            continue;
        }
        
        if (queryParams[item.name] == nil) {
            queryParams[item.name] = item.value;
        } else if ([queryParams[item.name] isKindOfClass:[NSArray class]]) {
            NSArray *values = (NSArray *)(queryParams[item.name]);
            queryParams[item.name] = [values arrayByAddingObject:item.value];
        } else {
            id existingValue = queryParams[item.name];
            queryParams[item.name] = @[existingValue, item.value];
        }
    }
    
    return queryParams.copy;
}

//把json解析为dictionary
+ (NSDictionary<NSString *, NSDictionary<NSString *, id> *> *)queryParameterFromJson:(NSString *)json {
    if (!json.length) {
        return nil;
    }
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if (error) {
        NSLog(@"WBRouter [Error] Wrong URL Query Format: \n%@", error.description);
    }
    return dic;
}

+ (WBUseMode)usage:(NSString *)usagePattern {
    //usagePattern = usagePattern.lowercaseString;
    
    Protocol *protocol = NSProtocolFromString(usagePattern);
    
    if (protocol) {
        return WBUseModeCallService;
    }else{
        return WBUseModeTargetAction;
    }
    
    return WBUseModeUnknown;
}

+ (WBRouterViewControlerEnterMode)viewControllerEnterMode:(NSString *)enterModePattern {
    enterModePattern = enterModePattern.lowercaseString;
    if ([enterModePattern isEqualToString:WBURLFragmentViewControlerEnterModePush]) {
        return WBRouterViewControlerEnterModePush;
    } else if ([enterModePattern isEqualToString:WBURLFragmentViewControlerEnterModeModal]) {
        return WBRouterViewControlerEnterModeModal;
    }
    return WBRouterViewControlerEnterModeUnknown;
}

+ (NSDictionary<NSString *, id> *)solveURLParams:(NSDictionary<NSString *, id> *)URLParams
                                  withFuncParams:(NSDictionary<NSString *, id> *)funcParams
                                        forClass:(Class)mClass {
    if (!URLParams) {
        URLParams = @{};
    }
    NSMutableDictionary<NSString *, id> *params = URLParams.mutableCopy;
    NSArray<NSString *> *funcParamKeys = funcParams.allKeys;
    [funcParamKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [params setObject:funcParams[obj] forKey:obj];
    }];
    
    return params;
}

+ (void)solveJumpWithViewController:(UIViewController *)viewController
                        andJumpMode:(WBRouterViewControlerEnterMode)enterMode
                      shouldAnimate:(BOOL)animate {
    
    if (enterMode == WBRouterViewControlerEnterModePush) {
        UIViewController *currViewController = [self currentViewController];
        [currViewController.navigationController pushViewController:viewController animated:YES];
    }else if (enterMode == WBRouterViewControlerEnterModeModal) {
        UIViewController *currViewController = [self currentViewController];
        [currViewController presentViewController:viewController animated:animate completion:^{
        }];
    }
}

+ (void)addressingErrorAlertWithToast:(NSString *)toast {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"WBRouter提示" message:toast preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil]];
    [[self currentViewController] presentViewController:alertController animated:YES completion:nil];
}

- (UINavigationController *)currentNavigationController {
    return [WBRouter currentViewController].navigationController;
}

+ (void)registerSwiftServiceMap:(NSString *)serviceName {
    if (serviceName.length == 0) return;
    NSArray<NSString *> *splitStr = [serviceName componentsSeparatedByString:@"_"];
    NSString *modName = splitStr.firstObject;
    NSString *targetName = splitStr.lastObject;
    [[WBRouter sharedInstance].serviceMap setValue:modName forKey:targetName];
}

#pragma mark - getter

- (NSMutableDictionary *)serviceMap {
    if (!_serviceMap) {
        _serviceMap = [NSMutableDictionary dictionary];
    }
    return _serviceMap;
}

- (NSMutableDictionary *)cachedService {
    if (_cachedService == nil) {
        _cachedService = [[NSMutableDictionary alloc] init];
    }
    return _cachedService;
}

- (NSObject *)safeFetchCachedService:(NSString *)key {
    @synchronized (self) {
        return self.cachedService[key];
    }
}

- (void)safeSetCachedService:(NSObject *)target key:(NSString *)key {
    @synchronized (self) {
        self.cachedService[key] = target;
    }
}

@end


static NSArray* TransformVariadicArgsToArray(va_list va_arguments) {
    NSMutableArray *arguments = [NSMutableArray array];
    
    id object;
    while ((object = va_arg( va_arguments, id ))) {
        [arguments addObject:object];
    }
    
    return [arguments copy];
}


const struct WBRouterUtils WBRouterUtils = {
    .transformVariadicArgsToArray = TransformVariadicArgsToArray
};
