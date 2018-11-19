//
//  BaseNavigationController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //设置全局title颜色
    
    NSMutableDictionary *titleAttributes = [NSMutableDictionary dictionary];
    
    titleAttributes[NSForegroundColorAttributeName] = BaseBlueColor;
    
    //    titleAttributes[NSFontAttributeName] = [UIFont fontWithName:@"Heiti SC" size:18];
    
    bar.titleTextAttributes = titleAttributes;
    
    [bar setBarTintColor:NavBackColor];
    
}

-(UIStatusBarStyle) preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //去掉底部线条
    if (@available(iOS 12.0, *)) {
        //iOS 12-设置底部线条颜色
        [self.navigationBar setShadowImage: [CommonMethods createImageWithColor:NavBackColor]];
    }else {
        //iOS 12以下隐藏
        UIImageView *navBarHairlineImageView;
        navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
        navBarHairlineImageView.hidden = YES;
    }

    //    设置阴影
    [self dropShadowWithOffset:CGSizeMake(1, 1) radius:3 color:[UIColor grayColor] opacity:0.5];
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.navigationBar.bounds);
    self.navigationBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.navigationBar.layer.shadowColor = color.CGColor;
    //阴影偏移度向右0 向下3
    self.navigationBar.layer.shadowOffset = offset;
    //阴影半径
    self.navigationBar.layer.shadowRadius = radius;
    //阴影透明度
    self.navigationBar.layer.shadowOpacity = opacity;
    
}


//push时隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"Nav_back"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 45, 45);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(backBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)backBarButtonItemAction {
    [self popViewControllerAnimated:YES];
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
