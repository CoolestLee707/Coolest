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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI1];
    
//    [self enumeratorMethod];

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
    
    
//    [button setExclusiveTouch:YES];
    
    
//    CGPoint redCenterInView = [self.backImageView convertPoint:CGPointMake(10, 10) toView:buttonView];
//    ADLog(@"++++ %@",NSStringFromCGPoint(redCenterInView));
}

- (void)backImageViewTapClick {
    ADLog(@"1111111111灰色灰色灰色灰色灰色灰色灰色灰色灰色灰色");
}
- (void)backSubViewTapClick {
    ADLog(@"2222222222黄色黄色黄色黄色黄色黄色黄色黄色黄色黄色");
}

- (void)didClickedButton {
    ADLog(@"33333333333蓝色蓝色蓝色蓝色蓝色蓝色蓝色蓝色蓝色蓝色");
}

- (void)subDidClickedButton {
    ADLog(@"44444444444红色红色红色红色红色红色红色红色红色红色");
}


- (void)dealloc
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
