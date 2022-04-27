//
//  WBRouter.h
//  WBCube
//
//  Created by 金修博 on 2018/6/18.
//  Copyright © 2018年 金修博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern const struct WBRouterUtils {
    NSArray* (*transformVariadicArgsToArray)(va_list va_arguments);
} WBRouterUtils;

@interface WBRouter : NSObject

#pragma mark - 当前导航控制器
@property (nonatomic, strong) NSMutableDictionary *serviceMap;

#pragma mark - 单例
+ (instancetype)sharedInstance;

#pragma mark - 通过路由地址调用
+ (BOOL)canOpenURL:(NSURL *)URL;
+ (BOOL)openURL:(NSURL *)URL;
+ (BOOL)openURL:(NSURL *)URL withParams:(NSDictionary<NSString *, NSString *> *)params;
+ (BOOL)openURL:(NSURL *)URL
     withParams:(NSDictionary<NSString *, NSString *> *)params
  customHandler:(void(^)(NSString *pathComponentKey, id obj, id returnValue))customHandler;

#pragma mark - 注册服务 & 获取服务类 & 通过plist文件注册服务
+ (id)createService:(Protocol *)protocol;
+ (void)registerService:(Protocol *)proto service:(Class)serviceClass;
+ (void)registerServiceWithPlistNames:(NSString *)plistName, ... NS_REQUIRES_NIL_TERMINATION;
+ (NSDictionary *)allServices;
+ (void)registerSwiftServiceMap:(NSString *)serviceName;

#pragma mark - Target-Action调用
+ (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;

@end
