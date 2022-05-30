//
//  HitTestViewController.m
//  Coolest
//
//  Created by daoj on 2018/8/10.
//  Copyright © 2018年 CoolestLee707. All rights reserved.


//hitTest:withEvent:方法会忽略以下视图：
//userInteractionEnabled = NO 的视图
//hidden = YES 的视图
//alpha<0.01 的视图
//超过父视图 frame 的视图（父试图的clipBound = NO）


#import "HitTestViewController.h"
#import "HitTestBackView.h"
#import "HitTestSubView.h"

@interface HitTestViewController ()

@property (nonatomic,strong)HitTestBackView *backImageView;
@property (nonatomic,strong)HitTestSubView *backSubView;

@end

@implementation HitTestViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ADLog(@"点击屏幕");
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
//    [self testButtonAddGesture];
    
    [self createUI1];
    
    
//    [self createUI2];
    
    
//    [self createUI3];

//    [self enumeratorMethod];

}

- (void)testButtonAddGesture {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = UIColor.redColor;
    [self.view addSubview:button];
    [button addTargetSelected:^(UIButton * _Nonnull button) {
        ADLog(@"点击button");
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTap)];
//    button上添加手势，默认不会响应button的点击，当手势的cancelsTouchesInView是NO时，button事件才会被调用，默认为YES。表示当手势识别器成功识别了手势之后，会通知Application取消响应链对事件的响应，并不再传递事件给hit-test view。
    tap.cancelsTouchesInView = NO;
    [button addGestureRecognizer:tap];
}
- (void)enumeratorMethod {
        NSArray *array = @[@"1",@"2",@"4",@"6",@"3",@"5",@"9",@"7",];

    //    18:21:19.36  3340
        ADLog(@"enumerator -- 开始");
        NSEnumerator *enumerator = [array objectEnumerator];
        id object;
        while ((object = [enumerator nextObject]) != nil) {
            ADLog(@"%@",object);
        }
    //    18:21:19.36  4265
        ADLog(@"enumerator -- 结束");
        
    //    18:21:19.36  4362
        ADLog(@"for -- 开始");
        for (int i=0; i<array.count; i++) {
            ADLog(@"%@",array[i]);
        }
        ADLog(@"for -- 结束");
    //    18:21:19.36  6275
}

- (void)createUI1
{
    self.backImageView = [[HitTestBackView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight + 200, self.view.frame.size.width, 100)];
    self.backImageView.userInteractionEnabled = YES;//has set YES
    self.backImageView.backgroundColor = [UIColor grayColor];
    self.backImageView.clipsToBounds = NO;
    UITapGestureRecognizer *backImageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backImageViewTapClick)];
    [self.backImageView addGestureRecognizer:backImageViewTap];
    
    [self.view addSubview:self.backImageView];
    
    self.backSubView = [[HitTestSubView alloc] initWithFrame:CGRectMake(50, 50, Main_Screen_Width-100, 100)];
    UITapGestureRecognizer *backSubViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backSubViewTapClick)];
    [self.backSubView addGestureRecognizer:backSubViewTap];

    self.backSubView.backgroundColor = [UIColor yellowColor];
    [self.backImageView addSubview:self.backSubView];

//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 30, 100, 100)];
//    button.backgroundColor = [UIColor blueColor];
//    button.nameId = @"histTest79";
//    [button setTitle:@"Click Me" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(didClickedButton) forControlEvents:UIControlEventTouchUpInside];
//    [self.backSubView addSubview:button];
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(100, 30, 100, 100)];
    buttonView.backgroundColor = [UIColor blueColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickedButton)];
    [buttonView addGestureRecognizer:tap];
    [self.backSubView addSubview:buttonView];

    UIView *subButtonView = [[UIView alloc] initWithFrame:CGRectMake(20, 30, 60, 100)];
    subButtonView.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *subTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(subDidClickedButton)];
    [subButtonView addGestureRecognizer:subTap];
    [buttonView addSubview:subButtonView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 530, 100, 100)];
    button.backgroundColor = [UIColor purpleColor];
    button.nameId = @"histTest79";
    [button setTitle:@"Click Me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UITapGestureRecognizer *buttonTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonTap)];
    [button addGestureRecognizer:buttonTap];
    
//  当手势的cancelsTouchesInView 是 NO时，button事件才会被调用,默认为YES。表示当手势识别器成功识别了手势之后，会通知Application取消响应链对事件的响应，并不再传递事件给hit-test view。
    buttonTap.cancelsTouchesInView = NO;
    
//    UITapGestureRecognizer *buttonTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonTap1)];
//    [button addGestureRecognizer:buttonTap1];
    
//setExclusiveTouch  是UIView的一个属性，默认为NO（不互斥），设置UIView 接收手势的互斥性为YES，防止多个响应区域被“同时”点击，“同时”响应的问题。可以通过  [[UIView appearance] setExclusiveTouch:YES]; UIImageView ，UILabel等，都可以添加手势，响应方式和UIButton 相同。全局设置响应区域的点击手势的互斥，是有效的。但使用此方法时，在iOS 8.0~iOS8.2（目前仅在该版本下发现问题）下会引起崩溃。
    [button setExclusiveTouch:YES];
    
//    CGPoint redCenterInView = [self.backImageView convertPoint:CGPointMake(10, 10) toView:buttonView];
//    ADLog(@"++++ %@",NSStringFromCGPoint(redCenterInView));
}

- (void)backImageViewTapClick {
    ADLog(@"灰灰灰灰灰灰灰灰灰灰灰");
}
- (void)backSubViewTapClick {
    ADLog(@"黄黄黄黄黄黄黄黄黄黄黄");
}

- (void)didClickedButton {
    ADLog(@"蓝蓝蓝蓝蓝蓝蓝蓝蓝蓝蓝");
}

- (void)subDidClickedButton {
    ADLog(@"红红红红红红红红红红红");
}

- (void)buttonClick {
    ADLog(@"%s",__func__);
}
- (void)buttonTap {
    ADLog(@"%s",__func__);
}
- (void)buttonTap1 {
    ADLog(@"%s",__func__);
}


- (void)createUI2 {
    
    HitTestBackView *backSubView = [[HitTestBackView alloc] initWithFrame:CGRectMake(0, 230, 300, 100)];
    backSubView.backgroundColor = [UIColor grayColor];
    backSubView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backImageViewTapClick)];
    [backSubView addGestureRecognizer:tap];
    [self.view addSubview:backSubView];
    
    HitTestBackView *buttonView1 = [[HitTestBackView alloc] initWithFrame:CGRectMake(-50, 0, 150, 100)];
    buttonView1.backgroundColor = [UIColor yellowColor];
    buttonView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backSubViewTapClick)];
    [buttonView1 addGestureRecognizer:tap1];
    [backSubView addSubview:buttonView1];
    
    HitTestBackView *buttonView2 = [[HitTestBackView alloc] initWithFrame:CGRectMake(200, -50, 100, 150)];
    buttonView2.backgroundColor = [UIColor blueColor];
    buttonView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickedButton)];
    [buttonView2 addGestureRecognizer:tap2];
    [backSubView addSubview:buttonView2];
    
    
    HitTestBackView *buttonView3 = [[HitTestBackView alloc] initWithFrame:CGRectMake(50, 30, 200, 100)];
    buttonView3.backgroundColor = [UIColor redColor];
    buttonView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(subDidClickedButton)];
    [buttonView3 addGestureRecognizer:tap3];
    [backSubView addSubview:buttonView3];
    
}

- (void)createUI3 {
    HitTestSubView *circleView = [[HitTestSubView alloc] initWithFrame:CGRectMake(50, 230, 100, 100)];
    circleView.backgroundColor = [UIColor redColor];
    circleView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(subDidClickedButton)];
    [circleView addGestureRecognizer:tap];
    [self.view addSubview:circleView];
}
- (void)dealloc {
    ADLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
