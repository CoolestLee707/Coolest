//
//  FourViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
    add.frame = CGRectMake(100, 100, 120,120);
    add.backgroundColor = [UIColor redColor];
    [self.view addSubview:add];
    
    [add addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *sdsd = [[UIView alloc]initWithFrame:CGRectMake(110, 150, 120,120)];
    sdsd.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sdsd];
    
    [sdsd setTapActionWithBlock:^{
        ADLog(@"22222");
    }];
    
    
}
- (void)click
{
    ADLog(@"1212");
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
