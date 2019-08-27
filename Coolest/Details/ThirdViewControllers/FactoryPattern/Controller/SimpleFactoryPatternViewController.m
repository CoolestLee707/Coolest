//
//  SimpleFactoryPatternViewController.m
//  Coolest
//
//  Created by daoj on 2019/8/20.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//简单工厂模式

#import "SimpleFactoryPatternViewController.h"
#import "SimpleFactory.h"
#import "ProductA.h"
#import "ProductB.h"

@interface SimpleFactoryPatternViewController ()

@end

@implementation SimpleFactoryPatternViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"简单工厂模式";
    
    //创建产品A
    ProductA *a =[SimpleFactory createProduct:NSStringFromClass(ProductA.class)];
    [a productMethod];
    //创建产品B
    ProductB *b =[SimpleFactory createProduct:NSStringFromClass(ProductB.class)];
    [b productMethod];

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
