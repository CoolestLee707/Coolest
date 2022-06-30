//
//  FrameAndBoundsViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/23.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "FrameAndBoundsViewController.h"

@interface FrameAndBoundsViewController ()

@property (nonatomic,strong)UIView * blueView;
@property (nonatomic,strong)UIView * redView;

@property (nonatomic,strong)UIScrollView *sc;

@end

@implementation FrameAndBoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FrameAndBounds";
    
    [self test1];
    
//    [self test2];
}

- (void)test2 {
    self.sc = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 100, 200, 200)];
    [self.view addSubview:self.sc];
    self.sc.backgroundColor = UIColor.redColor;
    [self.sc setContentSize:CGSizeMake(200, 300)];
    
    self.blueView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 200, 200)];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.sc addSubview:self.blueView];
    
}
- (void)test1 {
    self.blueView = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    self.blueView.bounds = CGRectMake(0, 0, 200, 200);
    self.redView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    self.redView.backgroundColor = [UIColor redColor];
    self.redView.bounds = CGRectMake(0, 0, 100, 100);
    [self.blueView addSubview:self.redView];
    NSLog(@"before***blueView-----frame:%@------bounds:%@---center:%@",NSStringFromCGRect(self.blueView.frame), NSStringFromCGRect(self.blueView.bounds),NSStringFromCGPoint(self.blueView.center));
    NSLog(@"before***redView-----frame:%@------bounds:%@---center:%@",NSStringFromCGRect(self.redView.frame), NSStringFromCGRect(self.redView.bounds),NSStringFromCGPoint(self.redView.center));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    /*
     更改了bounds里的size-------父视图中心点不变四周扩大，子-视觉位置变，相对父视图左上角点位置不变
     before***blueView-----frame:{{100, 200}, {200, 200}}------bounds:{{0, 0}, {200, 200}}---center:{200, 300}
     before***redView-----frame:{{50, 50}, {100, 100}}------bounds:{{0, 0}, {100, 100}}---center:{100, 100}
     after***blueView-----frame:{{50, 150}, {300, 300}}------bounds:{{0, 0}, {300, 300}}---center:{200, 300}
     after***redView-----frame:{{50, 50}, {100, 100}}------bounds:{{0, 0}, {100, 100}}---center:{100, 100}
    */
//    self.blueView.bounds = CGRectMake(0, 0, 300, 300);


    /*
     更改了bounds里的origin-------子-相对父视图左上移动
     before***blueView-----frame:{{100, 200}, {200, 200}}------bounds:{{0, 0}, {200, 200}}---center:{200, 300}
     before***redView-----frame:{{50, 50}, {100, 100}}------bounds:{{0, 0}, {100, 100}}---center:{100, 100}
     after***blueView-----frame:{{100, 200}, {200, 200}}------bounds:{{50, 50}, {200, 200}}---center:{200, 300}
     after***redView-----frame:{{50, 50}, {100, 100}}------bounds:{{0, 0}, {100, 100}}---center:{100, 100}
    */
//    self.blueView.bounds = CGRectMake(50, 50, 200, 200);
    
//    旋转，frame变化，bounds不变
//    after***blueView-----frame:{{63.397459621556138, 163.39745962155612}, {273.20508075688775, 273.20508075688781}}------bounds:{{0, 0}, {200, 200}}---center:{200, 300}
    
//    self.blueView.transform = CGAffineTransformRotate(self.blueView.transform, M_PI / 6);

    
    NSLog(@"after***blueView-----frame:%@------bounds:%@---center:%@",NSStringFromCGRect(self.blueView.frame), NSStringFromCGRect(self.blueView.bounds),NSStringFromCGPoint(self.blueView.center));
    NSLog(@"after***redView-----frame:%@------bounds:%@---center:%@",NSStringFromCGRect(self.redView.frame), NSStringFromCGRect(self.redView.bounds),NSStringFromCGPoint(self.redView.center));
    
    
//    self.sc.bounds = CGRectMake(0, 0, 300, 300);
//    UIScrollView 滑动会改变bounds的起点，x 或 y
//    NSLog(@"after***sc-----frame:%@------bounds:%@---center:%@",NSStringFromCGRect(self.sc.frame), NSStringFromCGRect(self.sc.bounds),NSStringFromCGPoint(self.sc.center));
//    NSLog(@"after***redView-----frame:%@------bounds:%@---center:%@",NSStringFromCGRect(self.redView.frame), NSStringFromCGRect(self.redView.bounds),NSStringFromCGPoint(self.redView.center));
}
@end
