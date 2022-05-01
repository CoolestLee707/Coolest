//
//  Service_testModule1.h
//  Coolest
//
//  Created by LiChuanmin on 2022/4/30.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

/*
    Target-Action调用
*/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Service_testModule1 : NSObject

- (NSDictionary *)action_log:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
