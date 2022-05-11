//
//  BlockTestObject.h
//  Coolest
//
//  Created by LiChuanmin on 2022/5/11.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockTestObject : NSObject

- (void)testMethod:(void(^)(void))block;

- (void)testMethodSave:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
