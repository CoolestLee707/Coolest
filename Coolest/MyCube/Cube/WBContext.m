//
//  WBContext.m
//  WBCube
//
//  Created by 金修博 on 2018/11/27.
//  Copyright © 2018 金修博. All rights reserved.
//

#import "WBContext.h"

@interface WBContext ()
@property(nonatomic, strong) NSMutableDictionary *servicesByModule;
@end

@implementation WBContext

+ (instancetype)shareInstance {
    static id _instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.openUrlItem = [[WBOpenUrlItem alloc] init];
        self.notificationItem = [[WBNotificationItem alloc] init];
        self.shortcutItem = [[WBShortcutItem alloc] init];
        self.userActivityItem = [[WBUserActivityItem alloc] init];
        self.watchItem = [[WBWatchItem alloc] init];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    WBContext *context = [[self.class allocWithZone:zone] init];
    context.env = self.env;
    context.application = self.application;
    context.launchOptions = self.launchOptions;
    context.customEvent = self.customEvent;
    context.customParam = self.customParam;
    context.openUrlItem = self.openUrlItem;
    context.notificationItem = self.notificationItem;
    context.shortcutItem = self.shortcutItem;
    context.userActivityItem = self.userActivityItem;
    context.watchItem = self.watchItem;
    return context;
}

- (void)addModuleServiceInstance:(id)instance serviceName:(NSString *)serviceName {
    [[WBContext shareInstance].servicesByModule setObject:instance forKey:serviceName];
}

- (id)getModuleServiceInstanceWithServiceName:(NSString *)serviceName {
    return [[WBContext shareInstance].servicesByModule objectForKey:serviceName];
}

- (void)removeModuleServiceInstanceWithServiceName:(NSString *)serviceName {
    [[WBContext shareInstance].servicesByModule removeObjectForKey:serviceName];
}

#pragma mark - property getter
- (NSMutableDictionary *)servicesByModule {
    if (!_servicesByModule) {
        _servicesByModule = [NSMutableDictionary dictionary];
    }
    return _servicesByModule;
}

@end


#pragma mark - WBOpenUrlItem
@implementation WBOpenUrlItem

@end


#pragma mark - WBNotificationItem
@implementation WBNotificationItem

@end

#pragma mark - WBShortcutItem
@implementation WBShortcutItem

@end

#pragma mark - WBUserActivityItem
@implementation WBUserActivityItem

@end

#pragma mark - WBWatchItem
@implementation WBWatchItem

@end
