//
//  FourViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "FourViewController.h"
#import "drawRectTestView.h"

@interface FourViewController ()

@property(nonatomic,strong)drawRectTestView *drawView;


//mutableArray若用copy修饰会返回一个NSArray类型，若调用可变类型的添加、删除、修改方法时会因为找不到对应的方法而crash
@property (nonatomic,strong)NSMutableArray *array;

@end

@implementation FourViewController

- (drawRectTestView *)drawView {
    if (!_drawView) {
        _drawView = [[drawRectTestView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height-kNavigationBarHeight)];
        //        _cir.backgroundColor = [UIColor whiteColor];
    }
    return _drawView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test2];
    
}

- (void)test2 {
    
//    self.array = [NSMutableArray array];
//    
//    [self.array addObject:@"1"];
    
    [self.view addSubview:self.drawView];

}
- (void)test1 {
 
    NSString *dsdsd = @"ffsdfsfdsfsXX";
    NSString *dsdsd1 = @"DDsdfsfdsfsXX";
    
    NSString *dsdsd2 = @"你是沙和尚";
    
    NSString *reStr = [dsdsd capitalizedString];
    NSString *reStr1 = [dsdsd1 capitalizedString];
    NSString *reStr2 = [dsdsd2 capitalizedString];
    
    ADLog(@"%@ - %@ - %@",reStr,reStr1,reStr2);
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
    add.frame = CGRectMake(100, 100, 120,120);
    add.backgroundColor = [UIColor redColor];
    [self.view addSubview:add];
    
    [add addTargetSelected:^(UIButton * _Nonnull button) {
        
        ADLog(@"11111");
        button.backgroundColor = [UIColor blackColor];
    }];
    
    //    [add addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *sdsd = [[UIView alloc]initWithFrame:CGRectMake(110, 150, 120,120)];
    sdsd.backgroundColor = [UIColor grayColor];
    //    [self.view addSubview:sdsd];
    
    [sdsd setTapActionWithBlock:^{
        ADLog(@"22222");
    }];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *arr = @[@"1",@"2",@"3",@"4"];
    
    NSArray *arr1 = @[@"1",@"2",@"1",@"3",@"5",@"2"];
    
    for (NSString *str in arr) {
        
        for (NSString *str1 in arr1) {
            
            if ([str1 isEqualToString:str]) {
                [array addObject:str];
                break;
            }
        }
    }
    
    ADLog(@"array - %@",array);
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
