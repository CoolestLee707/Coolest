//
//  Service_OpenLiveHome.h
//  Pods-LiveModule_Example
//
//  Created by LiChuanmin on 2022/7/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Service_OpenLiveHome : NSObject
- (void)action_OpenLive:(NSDictionary *)paramaters;
- (void)action_OpenLiveDetail:(NSDictionary *)paramaters;

@end

NS_ASSUME_NONNULL_END
