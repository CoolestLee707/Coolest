//
//  CoreTextViewController.m
//  Coolest
//
//  Created by daoj on 2018/9/17.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "CoreTextViewController.h"
#import "CoolDispalyView.h"

@interface CoreTextViewController ()

@end

@implementation CoreTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CoreText";
    
    //显示内容
    CoolDispalyView *dispaleView = [[CoolDispalyView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight+20, 300, 200)];
    dispaleView.center = self.view.center;
    dispaleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dispaleView];
    
    //访问成员变量->
    dispaleView->_name = @"1212";
    ADLog(@"dispaleView->_name - %@",dispaleView->_name);
    
    // Do any additional setup after loading the view.
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
