//
//  CubeRouterViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/30.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "CubeRouterViewController.h"
#import "WBCubeHeader.h"
#import "WBRouter.h"

#import "testModule3Protocol.h"
#import "Coolest-Swift.h" // 混编

@interface CubeRouterViewController ()

@end

@implementation CubeRouterViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
        barApp.backgroundColor = UIColor.yellowColor;
        self.navigationController.navigationBar.scrollEdgeAppearance = barApp;
        self.navigationController.navigationBar.standardAppearance = barApp;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
        barApp.backgroundColor = NavBackColor;
        self.navigationController.navigationBar.scrollEdgeAppearance = barApp;
        self.navigationController.navigationBar.standardAppearance = barApp;
    }
}


static void stringCleanUp(__strong NSString **string) {
    NSLog(@"%@",*string);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"testRouter";
    
//    在作用域结束时执行 stringCleanUp
    __strong NSString *string __attribute__((cleanup(stringCleanUp))) = @"lcmm";

    kWeakSelf(weakSelf);

    NSArray *urlButtonnArr = @[@"URL（Target-Action）OC",
                               @"URL（Target-Action）Swift",
                               @"URL（协议）OC",
                               @"URL（协议）Swift"];
    
    for (int i=0; i<urlButtonnArr.count; i++) {
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.tag = i;
        [self.view addSubview:btn1];
        btn1.titleLabel.font = [UIFont systemFontOfSize:13];
        btn1.frame = CGRectMake(10+(i%2*(Main_Screen_Width-10)/2), 150+(i/2)*70, (Main_Screen_Width-30)/2, 50);
        btn1.backgroundColor = UIColor.yellowColor;
        [btn1 setTitle:urlButtonnArr[i] forState:UIControlStateNormal];
        [btn1 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        __weak typeof(btn1)weakBtn1 = btn1;
        [btn1 addTargetSelected:^(UIButton * _Nonnull button) {
            [weakSelf btn1Click:weakBtn1];
        }];
    }
   
    NSArray *targetActionButtonnArr = @[@"Target-Action调用OC方法",@"Target-Action调用Swift方法"];
    for (int i=0; i<targetActionButtonnArr.count; i++) {
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:btn2];
        btn2.tag = i;
        btn2.titleLabel.font = [UIFont systemFontOfSize:13];
        btn2.frame = CGRectMake(10+(i%2*(Main_Screen_Width-10)/2), 320+(i/2)*70, (Main_Screen_Width-30)/2, 50);
        btn2.backgroundColor = UIColor.greenColor;
        [btn2 setTitle:targetActionButtonnArr[i] forState:UIControlStateNormal];
        [btn2 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        __weak typeof(btn2)weakBtn2 = btn2;
        [btn2 addTargetSelected:^(UIButton * _Nonnull button) {
            [weakSelf btn2Click:weakBtn2];
        }];
    }
   
    
    NSArray *protocolButtonnArr = @[@"通过协议调用OC方法",@"通过协议调用Swift方法"];

    for (int i=0; i<protocolButtonnArr.count; i++) {
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:btn3];
        btn3.tag = i;
        btn3.titleLabel.font = [UIFont systemFontOfSize:13];
        btn3.frame = CGRectMake(10+(i%2*(Main_Screen_Width-10)/2), 420+(i/2)*70, (Main_Screen_Width-30)/2, 50);
        btn3.backgroundColor = UIColor.redColor;
        [btn3 setTitle:protocolButtonnArr[i] forState:UIControlStateNormal];
        [btn3 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        __weak typeof(btn3)weakBtn3 = btn3;
        [btn3 addTargetSelected:^(UIButton * _Nonnull button) {
            [weakSelf btn3Click:weakBtn3];
        }];
    }
    UIButton *functionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:functionButton];
    functionButton.titleLabel.font = [UIFont systemFontOfSize:13];
    functionButton.frame = CGRectMake(10, 520, Main_Screen_Width-20, 50);
    functionButton.backgroundColor = UIColor.blueColor;
    [functionButton setTitle:@"OC调用Swift方法" forState:UIControlStateNormal];
    [functionButton setTitleColor:UIColor.yellowColor forState:UIControlStateNormal];
    [functionButton addTargetSelected:^(UIButton * _Nonnull button) {
        Service_testModule12 *swiftObject = [Service_testModule12 new];
        [swiftObject aaaaa:@"oc->swift"];
    }];
    
 
    
}


#pragma mark - 通过路由地址调用
- (void)btn1Click:(UIButton *)button {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // success callback
    params[@"success"] = ^(NSDictionary *result) {
        ADLog(@"success result - %@",result);
    };
    
    // fail callback
    params[@"fail"] = ^(NSDictionary *result) {
        ADLog(@"fail result - %@",result);
    };
    
    params[@"info"] = @{@"key1":@"value1",@"key2":@"value2"};

    switch (button.tag) {
        case 0:
        {
//            URL（Target-Action）OC
            [WBRouter openURL:[NSURL URLWithString:@"lichuanmin://testModule3/log3/#/modal"] withParams:params customHandler:^(NSString *pathComponentKey, id obj, id returnValue) {
                ADLog(@"%@-%@-%@",pathComponentKey,obj,returnValue);
            }];
        }
            break;
        case 1:
        {
//            URL（Target-Action）Swift - swift要提前注册
            [WBRouter openURL:[NSURL URLWithString:@"lichuanmin://testModule12/testSwiftMethod/#/modal"] withParams:params customHandler:^(NSString *pathComponentKey, id obj, id returnValue) {
                ADLog(@"%@-%@-%@",pathComponentKey,obj,returnValue);
            }];
        }
            break;
        case 2:
        {
//            URL（协议）OC
            [WBRouter openURL:[NSURL URLWithString:@"lichuanmin://testModule3Protocol/log3/#/modal"] withParams:params customHandler:^(NSString *pathComponentKey, id obj, id returnValue) {
                ADLog(@"%@-%@-%@",pathComponentKey,obj,returnValue);
            }];
        }
            break;
        case 3:
        {
//            URL（协议）Swift
            [WBRouter openURL:[NSURL URLWithString:@"lichuanmin://Coolest.SwiftProtocol/someOneTest"] withParams:params customHandler:^(NSString *pathComponentKey, id obj, id returnValue) {
                ADLog(@"%@-%@-%@",pathComponentKey,obj,returnValue);
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Target-Action调用
- (void)btn2Click:(UIButton *)button {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // success callback
    params[@"success"] = ^(NSDictionary *result) {
        ADLog(@"success result - %@",result);
    };
    
    // fail callback
    params[@"fail"] = ^(NSDictionary *result) {
        ADLog(@"fail result - %@",result);
    };
    
    params[@"info"] = @{@"key1":@"value1",@"key2":@"value2"};
    
    switch (button.tag) {
        case 0:
        {
//            调用 OC 方法
            NSDictionary *returnInfo = [WBRouter performTarget:@"testModule1" action:@"log" params:params];
            ADLog(@"returnInfo result - %@",returnInfo);
            break;
        }
        case 1:
        {
//            调用 Swift 方法
            NSDictionary *returnInfo = [WBRouter performTarget:@"testModule12" action:@"testSwiftMethod" params:params];
            ADLog(@"returnInfo result - %@",returnInfo);
            break;
        }
        default:
            break;
    }

}

#pragma mark - 通过协议调用
- (void)btn3Click:(UIButton *)button {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // success callback
    params[@"success"] = ^(NSDictionary *result) {
        ADLog(@"success result - %@",result);
    };
    // fail callback
    params[@"fail"] = ^(NSDictionary *result) {
        ADLog(@"fail result - %@",result);
    };
    params[@"info"] = @{@"key1":@"value1",@"key2":@"value2"};
        
    switch (button.tag) {
        case 0:
        {
            id<testModule3Protocol> p1 = [WBRouter createService:@protocol(testModule3Protocol)];
            NSDictionary *returnInfo = [p1 action_log3:params];
            ADLog(@"returnInfo result - %@",returnInfo);
        }
            break;
        case 1:
        {
            id<SwiftProtocol> p2 = [WBRouter createService:@protocol(SwiftProtocol)];
            [p2 action_someOneTest:params];
            [p2 action_someOneOCTest:^(NSDictionary * _Nonnull) {
                ADLog(@"action_someOneOCTest");
            }];
        }
            break;
        default:
            break;
    }
}

- (void)dealloc {
    ADLog(@"%s",__func__);
}
@end
