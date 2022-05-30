//
//  SonProxy.h
//  Coolest
//
//  Created by LiChuanmin on 2022/5/30.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "MyProxy.h"

NS_ASSUME_NONNULL_BEGIN

@interface SonProxy : MyProxy
+ (instancetype)proxyWithTarget:(id)target;
@property (weak, nonatomic) id target;
- (void)run;
- (void)eat;
@end

NS_ASSUME_NONNULL_END
