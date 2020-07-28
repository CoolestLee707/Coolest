//
//  CLPermenantThread.h
//  Coolest
//
//  Created by LiChuanmin on 2020/7/28.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CLPermenantThreadTask)(void);

@interface CLPermenantThread : NSObject

/**
 开启线程
 */
//- (void)run;

/**
 在当前子线程执行一个任务
 */
- (void)executeTask:(CLPermenantThreadTask)task;

/**
 结束线程
 */
- (void)stop;
@end

NS_ASSUME_NONNULL_END
