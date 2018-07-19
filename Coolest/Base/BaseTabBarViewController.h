//
//  BaseTabBarViewController.h
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarViewController : UITabBarController

- (void)showBadgeOnItemIndex:(NSInteger)index BadgeCount:(NSInteger)count;

@end
