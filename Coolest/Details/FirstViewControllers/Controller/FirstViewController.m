//
//  FirstViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "FirstViewController.h"
#import "RunLoopObject1.h"
#import "NSString+Hash.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    RunLoopObject1 *rl1 = [[RunLoopObject1 alloc]init];
//
//    NSTimer *timer1 = [NSTimer timerWithTimeInterval:1.0 target:rl1 selector:@selector(eat) userInfo:nil repeats:YES];
//
    //    [[NSRunLoop currentRunLoop]addTimer:timer1 forMode:NSRunLoopCommonModes];
    
    
    
    NSString *md5str1 = @"12312313";
    md5str1 = md5str1.md5String;
    ADLog(@"%@",md5str1);
    
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
