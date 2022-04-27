//
//  WBServiceManager.h
//  WBCube
//
//  Created by 金修博 on 2018/6/18.
//  Copyright © 2018年 金修博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBServiceManager : NSObject

@property (nonatomic, assign) BOOL enableException;

+ (instancetype)sharedManager;

- (void)registerLocalServices:(NSString *)plistName;

- (void)registerService:(Protocol *)service implClass:(Class)implClass;

- (id)createService:(Protocol *)service;

- (Class)implClassForService:(Protocol *)service;

- (NSDictionary *)allServices;

@end
