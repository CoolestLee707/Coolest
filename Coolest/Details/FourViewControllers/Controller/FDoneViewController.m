//
//  FDoneViewController.m
//  Coolest
//
//  Created by daoj on 2019/5/8.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "FDoneViewController.h"
#import "FDtwoViewController.h"

@interface FDoneViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation FDoneViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"添加到导航数组的的";
    
    //这里设置隐藏只有当前页面被push或者当前页面push一个新的才会有效
    self.fd_prefersNavigationBarHidden = YES;

    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Nav_back"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 45, 45);
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(backBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    // 隐藏tabbar
    self.hidesBottomBarWhenPushed = YES;

}
- (IBAction)btnClick {
    
    FDtwoViewController *vc = [[FDtwoViewController alloc]init];

    [self.navigationController pushViewController:vc animated:YES];
}
- (void)backBarButtonItemAction {
    
    [self.navigationController popViewControllerAnimated:YES];
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
