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
    
    int arr1[5] = {10,20,30,40,50};

    int arr[5] = {1,2,3,4,5};
    
    int arr2[5] = {100,200,300,400,500};

//    0x7ffee7ab5fb0,0x7ffee7ab5f90,0x7ffee7ab5f70
    ADLog(@"%p,%p,%p",arr1,arr,arr2);
        
    int *ptr = (int *)(&arr - 1); //int *ptr = (int *)(&arr+2) : ptr指向arr起始+arr*2大小的位置
    ADLog(@" ----- %d,%d",*(arr+1),*(ptr+1)); //2,500
    
    
//int 类型占4个字节，&arr + n，数组首地址 + n+sizeof(arr),在并不是连续的，中间有未知的？。
    
    
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
