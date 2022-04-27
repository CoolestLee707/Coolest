//
//  CLKeepAlive.h
//  Coolest
//
//  Created by LiChuanmin on 2020/9/1.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

//后台获取定位

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLKeepAlive : NSObject

+ (void)startKeepAliveInBackground;

+ (void)startLocation;

+ (void)stopLocation;

@end

@interface AppDelegate (AppKeepAlive)

@end

NS_ASSUME_NONNULL_END
