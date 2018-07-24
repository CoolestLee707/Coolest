//
//  NSObject+SwizzledMethod.h
//  Coolest
//
//  Created by daoj on 2018/7/24.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SwizzledMethod)


/**
 替换对象方法

 @param originalSEL 原方法
 @param swizzledSEL 替换的方法
 */
+ (void)swizzledInstanceSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;


/**
 替换类方法

 @param originalSEL 原方法
 @param swizzledSEL 替换的方法
 */
+ (void)swizzledClassSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;

@end
