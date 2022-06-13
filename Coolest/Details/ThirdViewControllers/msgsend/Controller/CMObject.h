//
//  CMObject.h
//  Coolest
//
//  Created by LiChuanmin on 2022/6/13.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMObject : NSObject
@property (nonatomic, strong) id target;
- (id)initWithObject:(id)object;
- (void)testAtomic;
@end

NS_ASSUME_NONNULL_END
