//
//  WBCube.h
//  WBCube
//
//  Created by 金修博 on 2018/11/27.
//  Copyright © 2018 金修博. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBContext;

@interface WBCube : NSObject

///保存了容器所有数据
@property(nonatomic, strong) WBContext *context;

+ (instancetype)shareInstance;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

#pragma mark - 模块
///注册模块
+ (void)registerModule:(Class)moduleClass;

#pragma mark - 模块服务
///添加模块服务实例对象
+ (void)addModuleServiceInstance:(id)instance serviceName:(NSString *)serviceName;

///获取模块服务实例对象
+ (id)getModuleServiceInstanceWithServiceName:(NSString *)serviceName;

///删除模块服务实例对象
+ (void)removeModuleServiceInstanceWithServiceName:(NSString *)serviceName;

#pragma mark - 触发事件
///触发事件
+ (void)triggerEvent:(NSString *)eventType;

///触发事件(携带自定义参数)
+ (void)triggerEvent:(NSString *)eventType customParam:(NSDictionary *)param;

@end
