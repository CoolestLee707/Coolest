//
//  CLTaskTimer.h
//  Coolest
//
//  Created by LiChuanmin on 2020/8/14.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

//封装GCD定时器

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLTaskTimer : NSObject

// block 形式任务
+ (NSString *)execTask:(void(^)(void))task
           start:(NSTimeInterval)start
        interval:(NSTimeInterval)interval
         repeats:(BOOL)repeats
           async:(BOOL)async;
// target selector 形式任务
+ (NSString *)execTask:(id)target
              selector:(SEL)selector
                 start:(NSTimeInterval)start
              interval:(NSTimeInterval)interval
               repeats:(BOOL)repeats
                 async:(BOOL)async;

+ (void)cancelTask:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
