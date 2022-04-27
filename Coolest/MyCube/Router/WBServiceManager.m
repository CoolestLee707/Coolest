//
//  WBServiceManager.m
//  WBCube
//
//  Created by 金修博 on 2018/6/18.
//  Copyright © 2018年 金修博. All rights reserved.
//

#import "WBServiceManager.h"
#import <objc/runtime.h>
#import "WBRouter.h"
#import "WBServiceProtocol.h"

static const NSString *kService = @"service";
static const NSString *kImpl = @"impl";

@interface WBServiceManager()
@property (nonatomic, strong) NSMutableDictionary *allServicesDict;
@property (nonatomic, strong) NSRecursiveLock *lock;
@property(nonatomic, strong) NSMutableDictionary *servicesByName;
@end

@implementation WBServiceManager

+ (instancetype)sharedManager {
    static WBServiceManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)registerLocalServices:(NSString *)plistName {

    NSString *plistPath = [[NSBundle bundleForClass:self.class] pathForResource:plistName ofType:@"plist"];
    
    if (!plistPath) {
        return;
    }
    
    NSArray *serviceList = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    [self.lock lock];
    for (NSDictionary *dict in serviceList) {
        NSString *protocolKey = [dict objectForKey:@"service"];
        NSString *protocolImplClass = [dict objectForKey:@"impl"];
        if (protocolKey.length > 0 && protocolImplClass.length > 0) {
            [self.allServicesDict addEntriesFromDictionary:@{protocolKey:protocolImplClass}];
        }
    }
    [self.lock unlock];
}

- (void)registerService:(Protocol *)service implClass:(Class)implClass {
    NSParameterAssert(service != nil);
    NSParameterAssert(implClass != nil);
    
    if (![implClass conformsToProtocol:service]) {
        if (self.enableException) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ module does not comply with %@ protocol", NSStringFromClass(implClass), NSStringFromProtocol(service)] userInfo:nil];
        }
        return;
    }
    
    if ([self checkValidService:service]) {
        if (self.enableException) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ protocol has been registed", NSStringFromProtocol(service)] userInfo:nil];
        }
        return;
    }
    
    NSString *key = NSStringFromProtocol(service);
    NSString *value = NSStringFromClass(implClass);
    
    if (key.length > 0 && value.length > 0) {
        [self.lock lock];
        [self.allServicesDict addEntriesFromDictionary:@{key:value}];
        [self.lock unlock];
    }
}

- (id)createService:(Protocol *)service {
    id implInstance = nil;
    
    if (![self checkValidService:service]) {
        if (self.enableException) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ protocol does not been registed", NSStringFromProtocol(service)] userInfo:nil];
        }
        
    }
    
    NSString *serviceStr = NSStringFromProtocol(service);
    id protocolImpl = [self.servicesByName objectForKey:serviceStr];
    if (protocolImpl) {
        return protocolImpl;
    }
    
    Class implClass = [self serviceImplClass:service];
    if ([[implClass class] respondsToSelector:@selector(singleton)]) {
        if ([[implClass class] singleton]) {
            if ([[implClass class] respondsToSelector:@selector(sharedInstance)])
                implInstance = [[implClass class] sharedInstance];
            else
                implInstance = [[implClass alloc] init];
            
            [self.servicesByName setObject:implInstance forKey:serviceStr];
            return implInstance;
        }
    }
    
    return [[implClass alloc] init];
}

- (Class)implClassForService:(Protocol *)service {
    NSString *key = NSStringFromProtocol(service);
    NSString *classStr = [[self servicesDict] valueForKey:key];
    return NSClassFromString(classStr);
}

#pragma mark - private
- (Class)serviceImplClass:(Protocol *)service {
    NSString *serviceImpl = [[self servicesDict] objectForKey:NSStringFromProtocol(service)];
    if (serviceImpl.length > 0) {
        return NSClassFromString(serviceImpl);
    }
    return nil;
}

- (BOOL)checkValidService:(Protocol *)service {
    NSString *serviceImpl = [[self servicesDict] objectForKey:NSStringFromProtocol(service)];
    if (serviceImpl.length > 0) {
        return YES;
    }
    return NO;
}

- (NSMutableDictionary *)allServicesDict {
    if (!_allServicesDict) {
        _allServicesDict = [NSMutableDictionary dictionary];
    }
    return _allServicesDict;
}

- (NSRecursiveLock *)lock {
    if (!_lock) {
        _lock = [[NSRecursiveLock alloc] init];
    }
    return _lock;
}

- (NSDictionary *)servicesDict {
    [self.lock lock];
    NSDictionary *dict = [self.allServicesDict copy];
    [self.lock unlock];
    return dict;
}

- (NSDictionary *)allServices {
    return self.servicesDict;
}

@end
