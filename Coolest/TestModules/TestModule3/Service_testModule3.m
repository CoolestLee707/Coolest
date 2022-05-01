//
//  testModule3.m
//  Coolest
//
//  Created by LiChuanmin on 2022/5/1.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "Service_testModule3.h"

typedef void (^ServiceCallBack)(NSDictionary *result);

@implementation Service_testModule3

//是否使用单例模式
+ (BOOL)singleton {
    return YES;
}
//单例对象
+ (id)sharedInstance {
    static Service_testModule3 *testM3 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        testM3 = [[self alloc]init];
    });
    return testM3;
}

- (NSDictionary *)action_log3:(NSDictionary *)params {
    
    ADLog(@"%s -- %@",__func__,params);
    
    ServiceCallBack success = [params objectForKey:@"success"];
    ServiceCallBack fail = [params objectForKey:@"fail"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        sleep(3);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (arc4random()%2==0) {
                NSDictionary *result = @{
                    @"code" : @0,
                    @"data" : @"successData",
                };
                !success ?: success(result);
            }else {
                NSDictionary *result = @{
                    @"code" : @1,
                    @"data" : @"failData",
                };
                !fail ?: fail(result);
            }
        });
    });
    return @{@"returnKey":@"method test3action_log success called"};
}
@end
