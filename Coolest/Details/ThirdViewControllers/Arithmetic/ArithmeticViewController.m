//
//  ArithmeticViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/30.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "ArithmeticViewController.h"

@interface ArithmeticViewController ()

@property (nonatomic,strong) UIView *view11;
@property (nonatomic,strong) UIView *view21;
@property (nonatomic,strong) UIView *view22;
@property (nonatomic,strong) UIView *view31;
@property (nonatomic,strong) UIView *view32;

@end

@implementation ArithmeticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"算法";
    
//    寻找两个视图最近的父视图
//    [self findParentView];
    
//    有序数组合并
    NSArray *arr1 = @[@1,@3,@5,@6];
    NSArray *arr2 = @[@2,@4,@5,@7];
    
//    NSArray *result = [self mergeArrayRecursive:arr1 And:arr2];
    NSArray *result = [self mergeArrayWhile:arr1 And:arr2];
    
    ADLog(@"%@",result);
}

#pragma mark -- 有序数组合并 - 递归
- (NSArray *)mergeArrayRecursive:(NSArray *)array1 And:(NSArray *)array2 {
    
    if (array1.count == 0) {
        return array2;
    }
    if (array2.count == 0) {
        return array1;
    }
    
    NSNumber *number1 = array1[0];
    NSNumber *number2 = array2[0];
    
    NSMutableArray *arr = @[].mutableCopy;
    if (number1.intValue < number2.intValue) {
        [arr addObject:number1];
        NSArray *temArr1 = [array1 subarrayWithRange:NSMakeRange(1, array1.count-1)];
        [arr addObjectsFromArray:[self mergeArrayRecursive:temArr1 And:array2]];
    }else {
        [arr addObject:number2];
        NSArray *temArr2 = [array2 subarrayWithRange:NSMakeRange(1, array2.count-1)];
        [arr addObjectsFromArray:[self mergeArrayRecursive:temArr2 And:array1]];
    }
    return arr.copy;
}
#pragma mark -- 有序数组合并 - 循环遍历
- (NSArray *)mergeArrayWhile:(NSArray *)array1 And:(NSArray *)array2  {
    
    NSMutableArray *result = @[].mutableCopy;
    int p = 0;
    int q = 0;
    
    while (p < array1.count && q < array2.count) {
        
        NSNumber *number1 = array1[p];
        NSNumber *number2 = array2[q];
        
        if (number1.intValue < number2.intValue) {
            [result addObject:number1];
            p++;
        }else {
            [result addObject:number2];
            q++;
        }
    }
    
    while (p < array1.count) {
        [result addObject: array1[p++]];
    }
    
    while (q < array2.count) {
        [result addObject: array2[q++]];
    }

    return result.copy;
}

#pragma mark -- 寻找两个视图最近的父视图
- (void)findParentView {
    self.view11 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.view11.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.view11];
    
    self.view21 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.view21.backgroundColor = UIColor.blueColor;
    [self.view11 addSubview:self.view21];
    
    self.view32 = [[UIView alloc]initWithFrame:CGRectMake(30, 30,50, 50)];
    self.view32.backgroundColor = UIColor.yellowColor;
    [self.view21 addSubview:self.view32];
    
    self.view22 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.view22.backgroundColor = UIColor.blackColor;
    [self.view11 addSubview:self.view22];
    
    self.view31 = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 80, 60)];
    self.view31.backgroundColor = UIColor.greenColor;
    [self.view22 addSubview:self.view31];
    
    UIView *returnView = [self findMinParent:self.view32 And:self.view22];
    ADLog(@"%@",returnView);
}

- (UIView *)findMinParent:(UIView *)view1 And:(UIView *)view2 {
    
    UIView *vP1 = [view1 superview];
    while (vP1) {
        
        UIView *vP2 = [view2 superview];

        while (vP2) {
            if (vP1 == vP2) {
                return vP1;
            }
            vP2 = [vP2 superview];
        }
        
       vP1 = [vP1 superview];
    }
    return nil;
}


@end
