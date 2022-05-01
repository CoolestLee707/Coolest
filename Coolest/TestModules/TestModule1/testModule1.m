//
//  testModule1.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/28.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "testModule1.h"
#import "WBCubeHeader.h"

@CubeEvents(testModule1)
@RouterServiceMap(Coolest, testModule12)

@interface testModule1 () <WBModuleProtocol>

@end

@implementation testModule1

///优先级,取值范围无上限,值越高优先级越高
- (WBModulePriority)priority {
    return WBModulePriorityDefault;
}

///安装模块
- (void)modInstallEvent:(WBContext *)context {
    ADLog(@"%s",__func__);
}
///初始化模块
- (void)modInitEvent:(WBContext *)context {
    ADLog(@"%s",__func__);
}
@end
