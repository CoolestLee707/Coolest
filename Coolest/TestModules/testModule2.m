//
//  testModule2.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/28.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "testModule2.h"
#import "WBCubeHeader.h"
#import "PasswordInputWindow.h"

@CubeEvents(testModule2)

@interface testModule2 ()<WBModuleProtocol>

@end

@implementation testModule2

///优先级,取值范围无上限,值越高优先级越高
- (WBModulePriority)priority {
    return WBModulePriorityHigh;
}

///安装模块
- (void)modInstallEvent:(WBContext *)context {
    ADLog(@"%s",__func__);
}

///初始化模块
- (void)modInitEvent:(WBContext *)context {
    ADLog(@"%s",__func__);
}

///App被挂起
- (void)modWillResignActiveEvent:(WBContext *)context {
    ADLog(@"%s",__func__);
    [[PasswordInputWindow shareInstance]show];
}
///App被挂起后复原
- (void)modDidBecomeActiveEvent:(WBContext *)context {
    ADLog(@"%s",__func__);
}

@end
