//
//  Service_testModule1.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/30.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "Service_testModule1.h"

typedef void (^ServiceCallBack)(NSDictionary *result);

@implementation Service_testModule1

- (NSDictionary *)action_log:(NSDictionary *)params {
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
    return @{@"returnKey":@"method action_log success called"};
}

@end
