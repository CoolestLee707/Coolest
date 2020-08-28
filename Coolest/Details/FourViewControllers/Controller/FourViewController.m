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
#import "FDoneViewController.h"
#import "FDtwoViewController.h"


@interface FourViewController ()

@property (nonatomic,strong)UIButton *animationButton;

@property (nonatomic,copy)NSString *testStr;

@property(nonatomic,strong)drawRectTestView *drawView;

//mutableArray若用copy修饰会返回一个NSArray类型，若调用可变类型的添加、删除、修改方法时会因为找不到对应的方法而crash
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,copy)NSMutableArray *copyarray;

@property (nonatomic,copy) NSMutableString *muStr;

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
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"1214";
    [view addSubview:label];
    
    ADLog(@"-------------superview ----- %@",label.superview);
    
//    NSMutableString *nameString = [NSMutableString  stringWithFormat:@"Antony"];

    // 用赋值NSMutableString给NSString赋值
    self.muStr = [NSMutableString  stringWithFormat:@"Antony"];
    
//    ADLog(@"----- %@---%p",nameString,nameString);
    ADLog(@"----- %@---%p",self.muStr,self.muStr);

    
//    崩溃-不可变不可appendString
//    [self.muStr appendString:@".Wong"];
    
//    ADLog(@"+++++++ %@---%p",nameString,nameString);
    ADLog(@"+++++++ %@---%p",self.muStr,self.muStr);


    
    
//    CGSize tempStringSize = [@"Valid from 2019-07-09 until until until 43" sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(250-40-5, MAXFLOAT)];
//    ADLog(@"----- %f",tempStringSize.height);
//
//    NSString *rer =@"216731273|";
//
//    NSArray *movieCodeArr = [rer componentsSeparatedByString:@"|"];
//
//    ADLog(@"%@",movieCodeArr);
//    [self fdT];
    
//    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
   
//    UIImageView *v =  [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
//    v.image = [UIImage imageNamed:@"Icon-60"];
//    
//    v.layer.cornerRadius=10;
//    v.layer.shadowColor=[UIColor redColor].CGColor;
//    v.layer.shadowOffset=CGSizeMake(10, 10);
//    v.layer.shadowOpacity=0.5;
//    v.layer.shadowRadius=5;
//    v.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:v];
//    
    
//    [self test2];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor blackColor];
//    label.text = @"eqweqweqw";
//    [self.view addSubview:label];
    
  
//    NSString *yearStr = [NSString getThisYearString];
//
    
//    ADLog(@"%@",yearStr);
    
//    NSString *dsdsd = @"2323,ddfdfd";
//    NSArray *positionsNumberArray = [@"1,2,3,4" componentsSeparatedByString:@","];

//    ADLog(@"%@",positionsNumberArray);
    
   

//    [self testSc];
    
//    [self testAnimation];
}

- (void)testAnimation{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(300, 100, 50, 50);
    button.backgroundColor = [UIColor blackColor];
    [self.view addSubview:button];

    [button addTarget:self action:@selector(blackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.animationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.animationButton.frame = CGRectMake(100, 100, 50, 50);
    self.animationButton.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.animationButton];
    
    [self.animationButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick {
    ADLog(@"----点击了button");
}

- (void)blackButtonClick {
    
//    [UIView animateWithDuration:8.0 animations:^{
//
//        self.animationButton.frame = CGRectMake(100, 700, 60, 60);
//
//    } completion:^(BOOL finished) {
//
//    }];
    
    [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut animations:^{
        self.animationButton.frame = CGRectMake(100, 700, 60, 60);
    } completion:^(BOOL finished) {
        
    }];

    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ADLog(@"点击屏幕");
}
- (void)testSc {
     UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height - kNavigationBarHeight - BottomBarHeight)];
        sc.backgroundColor = [UIColor orangeColor];
    //    sc.contentSize = CGSizeMake(sc.width*2, sc.height);

        [self.view addSubview:sc];

        UIView *v1 = [[UIView alloc]init];
        v1.backgroundColor = [UIColor blueColor];
        [sc addSubview:v1];


        UIView *v2 = [[UIView alloc]init];
        v2.backgroundColor = [UIColor redColor];
        [sc addSubview:v2];

    //    UIView *v3 = [[UIView alloc]init];
    //    v3.backgroundColor = [UIColor grayColor];
    //    [sc addSubview:v3];
        
    //    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.left.right.bottom.equalTo(@0);
    //    }];
        
        [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.width.height.mas_equalTo(sc);
        }];
        
        [v2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.width.height.mas_equalTo(sc);
            make.top.mas_equalTo(v1.mas_bottom);
        }];
        
        ADLog(@"--------%f",sc.bounds.size.height);
        ADLog(@"++++++++%f",sc.frame.size.height);
        ADLog(@"++++++++%f",sc.contentSize.height);
}
- (void)test2 {
    
    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
    NSArray *arr2 = @[].copy;
    
    self.array = arr1;
    self.copyarray = arr1;
    
    [self.array addObject:@"0"];
//    [self.copyarray addObject:@"a"];
    ADLog(@"%@-%@",self.array,self.copyarray);
//    ADLog(@"%@-%@",self.array.class,self.copyarray.class);

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


- (void)fdT
{
    kWeakSelf(weakSelf);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 120, 20, 20);
    [self.view addSubview:btn];
    [btn addTargetSelected:^(UIButton * _Nonnull button) {
        
//        FDoneViewController *vc = [[FDoneViewController alloc]init];
//        [weakSelf.navigationController pushViewController:vc animated:YES];
        
        NSMutableArray * viewControllers = [self.navigationController.viewControllers mutableCopy];//获取到当前导航控制器栈中所有vc
        
        UIViewController *vcB=[FDoneViewController new];
        UIViewController *vcC=[FDtwoViewController new];

        [viewControllers addObjectsFromArray:@[vcB]];
        
        [weakSelf.navigationController setViewControllers:viewControllers animated:NO];
        
        [weakSelf.navigationController pushViewController:vcC animated:NO];

    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
