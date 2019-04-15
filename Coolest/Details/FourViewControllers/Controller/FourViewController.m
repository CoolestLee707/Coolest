//
//  FourViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "FourViewController.h"
#import "drawRectTestView.h"
#import "BaseTabBarViewController.h"

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
    
    [self test1];
    
//    NSString *yearStr = [NSString getThisYearString];
//
    
//    ADLog(@"%@",yearStr);
    
    
//    NSString *dsdsd = @"2323,ddfdfd";
//    NSArray *positionsNumberArray = [@"1,2,3,4" componentsSeparatedByString:@","];

//    ADLog(@"%@",positionsNumberArray);
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
    
//    [add addTargetSelected:^(UIButton * _Nonnull button) {
//
//        ADLog(@"11111");
//        button.backgroundColor = [UIColor blackColor];
//    }];
    
    [add addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
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
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//
//    BaseTabBarViewController *tbc = (BaseTabBarViewController *)app.window.rootViewController;
//    tbc.tabBar.hidden = !tbc.tabBar.hidden;
}

- (void)firstTest1
{
    //    _myfirstname = @"123";
    //    ADLog(@"%@",_myfirstname);
    //    self.firstName = @"456";
    //    ADLog(@"%@",self.firstName);
    //    _myfirstname = @"789";
    //    ADLog(@"%@",_myfirstname);
    
    //    RunLoopObject1 *rl1 = [[RunLoopObject1 alloc]init];
    //
    //    NSTimer *timer1 = [NSTimer timerWithTimeInterval:1.0 target:rl1 selector:@selector(eat) userInfo:nil repeats:YES];
    //
    //    [[NSRunLoop currentRunLoop]addTimer:timer1 forMode:NSRunLoopCommonModes];
    
    
    
    //    NSString *md5str1 = @"12312313";
    //    md5str1 = md5str1.md5String;
    //    ADLog(@"%@",md5str1);
}
- (void)firstTest
{
    //    NSString *str1 = @"1212";
    //    NSString *str2 = [str1 copy];
    //    NSString *str3 = [str1 mutableCopy];
    //    ADLog(@"str1 -- %p",str1);
    //    ADLog(@"str2 -- %p",str2);
    //    ADLog(@"str3 -- %p",str3);
    //
    //    str1 = @"qqqqq";
    //    ADLog(@"str1 -- %@",str1);
    //    ADLog(@"str2 -- %@",str2);
    //    ADLog(@"str3 -- %@",str3);
    //
    //    ADLog(@"str1 -- %p",str1);
    //    ADLog(@"str2 -- %p",str2);
    //    ADLog(@"str3 -- %p",str3);
    
    NSMutableString * string = [NSMutableString stringWithFormat:@"1"];
    NSString * copyString = [string copy];
    NSString * mutableCopyString = [string mutableCopy];
    NSLog(@"++string:%p - %@", string, string);
    NSLog(@"++copyString:%p - %@", copyString, copyString);
    NSLog(@"++mutableCopString:%p - %@", mutableCopyString, mutableCopyString);
    [string appendString:@",2"];
    NSLog(@"++string:%p - %@", string, string);
    NSLog(@"++copyString:%p - %@", copyString, copyString);
    NSLog(@"++mutableCopString:%p - %@", mutableCopyString, mutableCopyString);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
