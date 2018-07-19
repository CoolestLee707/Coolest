//
//  BaseTabBarViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationController.h"

@interface BaseTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarViewController

+ (void)initialize
{
    UITabBarItem *appearance = [UITabBarItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = BaseBlueColor;
    [appearance setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    [appearance setTitlePositionAdjustment:UIOffsetMake(0, -3)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self buildShadow];
    
    [self buildUI];
}

- (void)buildShadow
{
    //添加阴影
    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -5);
    self.tabBar.layer.shadowOpacity = 0.3;
    
    self.tabBar.backgroundImage = [[UIImage alloc]init];
    self.tabBar.shadowImage = [[UIImage alloc]init];
    
}
/**构建视图*/
- (void)buildUI{
    
    self.tabBar.translucent     = NO;
    
    NSArray * normalItems       = @[@"tabbar_icon1_normal",@"tabbar_icon2_normal",@"tabbar_icon3_normal",@"tabbar_icon4_normal"];
    NSArray * selectItmes       = @[@"tabbar_icon1_selected",@"tabbar_icon2_selected",@"tabbar_icon3_selected",@"tabbar_icon4_selected"];
    
    NSArray * controllClass     = @[@"FirstViewController",@"SecondViewController",@"ThirdViewController",@"FourViewController"];
    self.delegate               = self;
    NSArray * itemTitles        = @[@"First",@"Second",@"Third",@"Four"];
    NSMutableArray * controllers = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < normalItems.count; i++)
    {
        UIViewController * homeview =[[NSClassFromString(controllClass[i]) alloc]init];
        BaseNavigationController * navigation =[[BaseNavigationController alloc]initWithRootViewController:homeview];
        navigation.tabBarItem.image                     = [[UIImage imageNamed:normalItems[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navigation.tabBarItem.selectedImage             = [[UIImage imageNamed:selectItmes[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [controllers addObject:navigation];
        
        // 设置tabbaritem 的title
        navigation.tabBarItem.title                     = itemTitles[i];
    }
    
    self.viewControllers = controllers;
    
    //tabbar 背景色
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, BottomBarHeight)];
    backView.backgroundColor = TabbarColor;
    [self.tabBar insertSubview:backView atIndex:0];
    
}

- (void)showBadgeOnItemIndex:(NSInteger)index BadgeCount:(NSInteger)count {
    
    if (index >= self.viewControllers.count) {
        return;
    }
    UINavigationController  *discoverNav =(UINavigationController *)self.viewControllers[index];
    UITabBarItem *curTabBarItem=discoverNav.tabBarItem;
    
    if (count) {
        [curTabBarItem setBadgeValue:[NSString stringWithFormat:@"%zd",count]];
    }else {
        [curTabBarItem setBadgeValue:nil];
    }
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
