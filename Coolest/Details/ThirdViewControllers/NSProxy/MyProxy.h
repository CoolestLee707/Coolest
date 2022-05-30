//
//  MyProxy.h
//  Coolest
//
//  Created by LiChuanmin on 2022/5/30.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;
@property (weak, nonatomic) id target;

- (void)eat;
@end

NS_ASSUME_NONNULL_END
