//
//  RACView.m
//  Coolest
//
//  Created by daoj on 2019/3/27.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "RACView.h"

@interface RACView ()

@property (nonatomic,strong)UIButton *button;

@end

@implementation RACView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self setSubviews];
        
//        [self setTextField];

    }
    return self;
}

- (void)setTextField
{
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 30)];
    self.textField.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.textField];
    
}
- (void)setSubviews
{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(100, 100, 100, 100);
    self.button.backgroundColor = [UIColor redColor];
    [self addSubview:self.button];
    [self.button addTarget:self action:@selector(btnClcik:) forControlEvents:UIControlEventTouchUpInside];
    
    self.racSingnal = [RACSubject subject];
    
}

- (void)btnClcik:(UIButton *)btn
{
    [self.racSingnal sendNext:@"来了老弟"];
    self.frame = CGRectMake(10, 50, 500, 600);

}
@end
