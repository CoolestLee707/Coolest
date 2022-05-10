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
//    NSArray *arr1 = @[@1,@3,@5,@6];
//    NSArray *arr2 = @[@2,@4,@5,@7];
    
//    NSArray *result = [self mergeArrayRecursive:arr1 And:arr2];
//    NSArray *result = [self mergeArrayWhile:arr1 And:arr2];
//    ADLog(@"%@",result);
    
//    hash查找字符串中只出现一次的字符
//    NSString *str = @"ujklfjsdlfjslfsp";
//    ADLog(@"%@",[self selectOnlyOnceString:str]);
    
//    冒泡排序
//    NSMutableArray *sortArray = @[@2,@1,@8,@7,@20,@3,@13,@18,@30,@20,@27,@9,@7].mutableCopy;
//    [self sort1:sortArray];
    
//    求一个无序数组的中位数
//    int list[10] = {12,3,10,8,6,7,11,13,9,6};
//    int midResult = findMedian(list,10);
//    printf("midResult %d",midResult);
    
    
//    快速排序
//    int list[10] = {12,3,10,8,6,7,11,13,9,6};
//    sortQuickly(list,0,9);
//
//    for (int i=0; i<10; i++) {
//        printf("%d ", list[i]);
//    }
    
    NSArray *arr = @[@"0",@"1",@"3",@"2",@"2",@"2",@"2",@"2"];
    int value = [self selectMostNumber:arr];
    ADLog(@"value - %d",value);
}
// 寻找出现次数一半以上的
- (int)selectMostNumber:(NSArray *)array {
    int returnNumber = 0;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (int i = 0; i<array.count; i++) {
        NSString *number = array[i];
        NSString *value = dic[number];

        if (!value) {
            dic[number] = @"1";
        }else {
            int newValue = value.intValue + 1;
            dic[number] = [NSString stringWithFormat:@"%d",newValue];
        }
    }
    for (int i = 0; i<dic.allKeys.count; i++) {
        NSString *number = dic.allKeys[i];
        NSString *value = dic[number];
        if (value.intValue > array.count/2) {
            return number.intValue;
        }
    }
    return returnNumber;
}

#pragma mark --- 快速排序 小->大
void sortQuickly(int a[],int left,int right) {
    if (left >= right) {
        return;
    }
    int i = left;
    int j = right;
    int key = a[left];
    
    while (i < j) {
//        从末尾开始找一个比key小的数换位置，小的放前面
        while (i < j && key <= a[j]) {
            j--;
        }
        a[i] = a[j];
//        从开头开始找一个比key大的数，放到刚找到的小的数位置
        while (i < j && key >= a[i]) {
            i++;
        }
        a[j] = a[i];
    }
//    中间数key放到中间位置
    a[i] = key;
    sortQuickly(a, left, i-1);
    sortQuickly(a, i+1, right);
}

#pragma mark -- hash查找字符串中只出现一次的字符
- (NSString *)selectOnlyOnceString:(NSString *)str {
    int i = 0;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    while (i < str.length) {
        NSString *s = [str substringWithRange:NSMakeRange(i++, 1)];
        NSNumber *count = [dic objectForKey:s];
        if (count) {
            count = @(count.intValue + 1);
            [dic setValue:count forKey:s];
        }else {
            [dic setValue:@1 forKey:s];
        }
    }
    
    i = 0;
    while (i < str.length) {
        NSString *s = [str substringWithRange:NSMakeRange(i++, 1)];
        NSNumber *count = [dic objectForKey:s];
        if (count.intValue == 1) {
            return s;
        }
    }
    return nil;
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

#pragma mark -- 寻找两个视图的父视图
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
    
//    寻找两个视图最近的父视图
    UIView *returnView = [self findMinParent:self.view32 And:self.view31];
    ADLog(@"findAllParents - %@",returnView);
    
//    寻找两个视图最近的父视图
    NSArray *allViews = [self findAllParents:self.view32 And:self.view31];
    ADLog(@"allViews - %@",allViews);
}

//寻找两个视图最近的父视图
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

//寻找两个视图所有的父视图
- (NSArray *)findAllParents:(UIView *)view1 And:(UIView *)view2 {
    NSMutableArray *array1 = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *array2 = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];

    UIView *tempView1 = view1.superview;
    while (tempView1) {
        [array1 addObject:tempView1];
        tempView1 = tempView1.superview;
    }
    
    UIView *tempView2 = view2.superview;
    while (tempView2) {
        [array2 addObject:tempView2];
        tempView2 = tempView2.superview;
    }
    
    for (int i=0; i<MIN(array1.count, array2.count); i++) {
        
        UIView *viewA = array1[array1.count-i-1];
        UIView *viewB = array2[array2.count-i-1];
        if (viewA == viewB) {
            [resultArray addObject:viewA];
        }else {
            break;
        }
    }
    return resultArray.copy;
}

//冒泡排序
- (void)sort1:(NSMutableArray *)numbers {
    
    for (int i=0; i<numbers.count-1; i++) {
        for (int j=0; j<numbers.count-1-i; j++) {
            NSNumber *a = numbers[j];
            NSNumber *b = numbers[j+1];
            if (a.intValue > b.intValue) {
                numbers[j] = b;
                numbers[j+1] = a;
            }
        }
    }
    ADLog(@"%@",numbers);
}

//求一个无序数组的中位数
int findMedian(int a[], int aLen) {
    int low = 0;
    int high = aLen - 1;
    
    int mid = (aLen - 1) / 2;
    int div = PartSort(a, low, high);
    
    while (div != mid)
    {
        if (mid < div)
        {
            //左半区间找
            div = PartSort(a, low, div - 1);
        }
        else
        {
            //右半区间找
            div = PartSort(a, div + 1, high);
        }
    }
    //找到了
    return a[mid];
}

int PartSort(int a[], int start, int end) {
    int low = start;
    int high = end;
    
    //选取关键字
    int key = a[end];
    
    while (low < high) {
        
        //左边找比key大的值
        while (low < high && a[low] <= key) {
            ++low;
        }
        
        //右边找比key小的值
        while (low < high && a[high] >= key) {
            --high;
        }
        
        if (low < high) {
            //找到之后交换左右的值
            int temp = a[low];
            a[low] = a[high];
            a[high] = temp;
        }
    }
    
    int temp = a[high];
    a[high] = a[end];
    a[end] = temp;
    
    return low;
}




@end
