//
//  UIButton+TestButtonC.h
//  Coolest
//
//  Created by LiChuanmin on 2022/6/1.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (TestButtonC)

// 设置内边距范围
-(void)setEnLargeEdge:(CGFloat)size;

// 设置具体范围, 到上、右、下、左的距离
-(void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end

NS_ASSUME_NONNULL_END
