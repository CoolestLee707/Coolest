//
//  UITabBar+badge.h
//  Coolest
//
//  Created by LiChuanmin on 2022/5/8.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index msgCount:(int)count;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end

NS_ASSUME_NONNULL_END
