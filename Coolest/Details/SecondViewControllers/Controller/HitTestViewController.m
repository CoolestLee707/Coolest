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

@interface HitTestViewController ()

@property (nonatomic,strong)HitTestBackView *backImageView;

@end

@implementation HitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self createUI1];
    
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
    self.backImageView = [[HitTestBackView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight + 10, self.view.frame.size.width, 100)];
    self.backImageView.userInteractionEnabled = YES;//has set YES
    self.backImageView.backgroundColor = [UIColor grayColor];
    self.backImageView.clipsToBounds = NO;
    [self.view addSubview:self.backImageView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, self.backImageView.height-10, 100, 50)];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"Click Me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickedButton) forControlEvents:UIControlEventTouchUpInside];
    [self.backImageView addSubview:button];
    

}

- (void)didClickedButton
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tips" message:@"Alert" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alertView show];
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
