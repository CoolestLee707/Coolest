//
//  weakTestView.m
//  Coolest
//
//  Created by daoj on 2019/5/30.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "weakTestView.h"

@implementation weakTestView

- (instancetype)initWeakTestView
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        
        [self setSubViews];
    }
    return self;

}
- (void)setSubViews
{
    self.frame = CGRectMake(0, 200, Main_Screen_Width, 130);

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self addGestureRecognizer:tap];
}

- (void)tapClick
{
    if (self.touchBlock) {
        self.touchBlock(@"1");
    }
//    [self removeFromSuperview];//所有对其他对象的持有（强弱）都断掉
}
@end
