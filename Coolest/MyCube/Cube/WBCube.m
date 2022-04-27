//
//  WBCube.m
//  WBCube
//
//  Created by 金修博 on 2018/11/27.
//  Copyright © 2018 金修博. All rights reserved.
//

#import "WBCube.h"
#import "WBModuleManager.h"
#import "WBContext.h"

@implementation WBCube

+ (instancetype)shareInstance {
    static id _instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

+ (void)registerModule:(Class)moduleClass {
    [[WBModuleManager shareInstance] registerModule:moduleClass];
}

+ (void)triggerEvent:(NSString *)eventType {
    [[WBModuleManager shareInstance] triggerEvent:eventType];
}

+ (void)triggerEvent:(NSString *)eventType customParam:(NSDictionary *)param {
    [[WBModuleManager shareInstance] triggerEvent:eventType customParam:param];
}

+ (void)addModuleServiceInstance:(id)instance serviceName:(NSString *)serviceName {
    [[WBContext shareInstance] addModuleServiceInstance:instance serviceName:serviceName];
}

+ (id)getModuleServiceInstanceWithServiceName:(NSString *)serviceName {
    return [[WBContext shareInstance] getModuleServiceInstanceWithServiceName:serviceName];
}

+ (void)removeModuleServiceInstanceWithServiceName:(NSString *)serviceName {
    [[WBContext shareInstance] removeModuleServiceInstanceWithServiceName:serviceName];
}

@end
