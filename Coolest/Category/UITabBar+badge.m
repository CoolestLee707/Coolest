//
//  UITabBar+badge.m
//  Coolest
//
//  Created by LiChuanmin on 2022/5/8.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "UITabBar+badge.h"
#define TabbarItemNums 4.0    //tabbar的数量

@implementation UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index msgCount:(int)count{
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.62) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.05 * tabFrame.size.height);

    badgeView.frame = CGRectMake(x, y, 15, 15);
    badgeView.layer.cornerRadius = badgeView.width/2;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, badgeView.frame.size.width, badgeView.frame.size.height)];
    [badgeView addSubview:label];
    label.text = [NSString stringWithFormat:@"%d",count];
    label.textColor = UIColor.blueColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    [self addSubview:badgeView];
    
}

- (void)hideBadgeOnItemIndex:(int)index{
    
    //移除小红点
    [self removeBadgeOnItemIndex:index];
    
}

- (void)removeBadgeOnItemIndex:(int)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 888+index) {
            
            [subView removeFromSuperview];
            
        }
    }
}

@end
