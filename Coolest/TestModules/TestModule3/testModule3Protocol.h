//
//  testModule3Protocol.h
//  Coolest
//
//  Created by LiChuanmin on 2022/5/1.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol testModule3Protocol <NSObject,WBServiceProtocol>

- (NSDictionary *)action_log3:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
