//
//  CLKeepAlive.m
//  Coolest
//
//  Created by LiChuanmin on 2020/9/1.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "CLKeepAlive.h"
#import <CoreLocation/CoreLocation.h>

@interface CLKeepAlive ()<CLLocationManagerDelegate>

//@property (nonatomic,strong) CLLocationManager *appleLocationManager;

@end

static CLKeepAlive *CLKeepAliveManager = nil;
static CLLocationManager *cllocationManager = nil;

dispatch_source_t _CLKeepAlivebadgeTimer;

@implementation CLKeepAlive

+ (instancetype)sharedKeepAlive
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CLKeepAliveManager = [[CLKeepAlive alloc]init];
        cllocationManager = [[CLLocationManager alloc] init];
        cllocationManager.allowsBackgroundLocationUpdates = YES;
        cllocationManager.desiredAccuracy = kCLLocationAccuracyBest;
        cllocationManager.delegate = CLKeepAliveManager;
        [cllocationManager requestAlwaysAuthorization];
    });
    
    return CLKeepAliveManager;
}


+ (void)startKeepAliveInBackground {
    
}

+ (void)startLocation {
    
    CLKeepAliveManager = [self sharedKeepAlive];
    [CLKeepAliveManager CL_startLoaction];
    
}

- (void)CL_startLoaction {
    
//    self.appleLocationManager = [[CLLocationManager alloc] init];
//    self.appleLocationManager.allowsBackgroundLocationUpdates = YES;
//    self.appleLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    self.appleLocationManager.delegate = self;
//    [self.appleLocationManager requestAlwaysAuthorization];
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    dispatch_async(queue, ^{
        
        _CLKeepAlivebadgeTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_CLKeepAlivebadgeTimer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_CLKeepAlivebadgeTimer, ^{
            
            [cllocationManager startUpdatingLocation];
            
        });
        dispatch_resume(_CLKeepAlivebadgeTimer);
    });
}

+ (void)stopLocation {
    
}

/** 位置更新后，会调用此函数 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [cllocationManager stopUpdatingLocation];
    NSLog(@"success");
}

/** 定位失败后，会调用此函数 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [cllocationManager stopUpdatingLocation];
    NSLog(@"error");
}

@end


@implementation AppDelegate (AppKeepAlive)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        SEL originalSEL = @selector(applicationDidEnterBackground:);
        SEL swizzledSEL = @selector(keepAliveApplicationDidEnterBackground:);

        Method originalMethod = class_getInstanceMethod(class, originalSEL);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);

        BOOL didAddMethod = class_addMethod(class, originalSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}

- (void)keepAliveApplicationDidEnterBackground:(UIApplication *)application {

    [self keepAliveApplicationDidEnterBackground:application];
    
    [self startBgTask];
}

- (void)startBgTask{
    
    UIApplication *application = [UIApplication sharedApplication];
    __block  UIBackgroundTaskIdentifier bgTask;
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
}

@end

