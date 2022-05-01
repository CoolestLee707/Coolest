//
//  WBAnnotation.m
//  WBCube
//
//  Created by 金修博 on 2019/1/14.
//  Copyright © 2019 金修博. All rights reserved.
//

#import "WBAnnotation.h"
#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>
#import <objc/runtime.h>
#import <objc/message.h>
#include <mach-o/ldsyms.h>
#import "WBRouter.h"
#import "WBModuleManager.h"

NSArray<NSString *>* WBReadConfiguration(char *sectionName,const struct mach_header *mhp);
//传入文件的mach_header以及一个虚拟内存地址 intptr_t。
static void dyld_callback(const struct mach_header *mhp, intptr_t vmaddr_slide) {
    NSArray *mods = WBReadConfiguration(CubeModSectName, mhp);
    NSArray *services = WBReadConfiguration(RouterSerSectName, mhp);
    NSArray<NSString *> *protocolService = WBReadConfiguration(ProtocolSerSectName,mhp);
    NSArray<NSString *> *swiftProtocolService = WBReadConfiguration(ProtocolSwiftSerSectName, mhp);
    // 注册模块，处理优先级、方法回调等
    for (NSString *modName in mods) {
        Class cls;
        if (modName) {
            cls = NSClassFromString(modName);
            
            if (cls) {
                [[WBModuleManager shareInstance] registerModule:cls];
            }
        }
    }
    // Swift模块Service注册
    for (NSString *service in services) {
        if (service) {
            [WBRouter registerSwiftServiceMap:service];
        }
    }
    // 注册协议
    NSMutableArray * allProArray = [[NSMutableArray alloc]initWithArray:protocolService];
    [allProArray addObjectsFromArray:swiftProtocolService];
    for (NSString * protocols in allProArray) {
        NSData *jsonData =  [protocols dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (!error) {
            if ([json isKindOfClass:[NSDictionary class]] && [json allKeys].count) {
                NSString *protocol = [json allKeys][0];
                NSString *clsName  = [json allValues][0];
                if (protocol && clsName) {
                    [WBRouter registerService:NSProtocolFromString(protocol) service:NSClassFromString(clsName)];
                }
            }
        }
    }
}
__attribute__((constructor))
void initProphet() {
//_dyld_register_func_for_add_image：这个函数是用来注册回调，当dyld链接符号时，调用此回调函数。在dyld加载镜像时，会执行注册过的回调函数
    _dyld_register_func_for_add_image(dyld_callback);
}

// 读取数据
NSArray<NSString *>* WBReadConfiguration(char *sectionName,const struct mach_header *mhp) {
    NSMutableArray *configs = [NSMutableArray array];
    unsigned long size = 0;
#ifndef __LP64__
    // 读取存贮的服务的section地址
    uintptr_t *memory = (uintptr_t*)getsectiondata(mhp, SEG_DATA, sectionName, &size);
#else
    const struct mach_header_64 *mhp64 = (const struct mach_header_64 *)mhp;
    // 读取存贮的服务的section地址
    uintptr_t *memory = (uintptr_t*)getsectiondata(mhp64, SEG_DATA, sectionName, &size);
#endif
   
    
//     遍历改section获取服务的protocol以及class
    unsigned long counter = size/sizeof(void*);
    for(int idx = 0; idx < counter; ++idx){
        char *string = (char*)memory[idx];
        NSString *str = [NSString stringWithUTF8String:string];
        if(!str)continue;

        if(str) [configs addObject:str];
    }
    
    return configs;
}

@implementation WBAnnotation

@end
