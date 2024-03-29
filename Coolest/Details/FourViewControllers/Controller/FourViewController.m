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
//#import "CLTaskTimer.h"
#import "CLKeepAlive.h"
#import "objc1.h"

@interface FourViewController ()

@property (nonatomic,strong)UIButton *animationButton;

@property (nonatomic,copy)NSString *testStr;

@property(nonatomic,strong)drawRectTestView *drawView;

//mutableArray若用copy修饰会返回一个NSArray类型，若调用可变类型的添加、删除、修改方法时会因为找不到对应的方法而crash
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,copy)NSMutableArray *copyarray;

@property (nonatomic,copy) NSMutableString *muStr;

@property (nonatomic,assign) int count;

@property (nonatomic,strong) UILabel *actLabel;

@property (nonatomic,assign) objc1 *objc1;

@property (strong, nonatomic) NSLock *nsLock;
@property (strong, nonatomic) NSRecursiveLock *recursiveLock;

@end

@implementation FourViewController

- (drawRectTestView *)drawView {
    if (!_drawView) {
        _drawView = [[drawRectTestView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height-kNavigationBarHeight)];
        //        _cir.backgroundColor = [UIColor whiteColor];
    }
    return _drawView;
}

- (void)viewWillAppear:(BOOL)animated {
    
//    [self.objc1 run];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testNSLock];
    
//    [self testAssign];
    

//    NSArray *arr = @[[NSObject new], [NSObject new], [NSObject new]];
//    NSMutableArray *arr1 = [NSMutableArray array];
//    for (int i=0; i<3; i++) {
//        NSObject *obj = [NSObject new];
//        [arr1 addObject:obj];
//    }
//    ADLog(@"%p - %p -%p",arr[0],arr[1],arr[2]);
//
//    ADLog(@"%p - %p -%p",arr1[0],arr1[1],arr1[2]);
    

//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        ADLog(@"currentThread%@",[NSThread currentThread]);
//        self.view.backgroundColor = UIColor.cyanColor;
//    });
    
       
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
  
    
//    ADLog(@"-------------superview ----- %@",label.superview);
    
//    NSMutableString *nameString = [NSMutableString  stringWithFormat:@"Antony"];

    // 用赋值NSMutableString给NSString赋值
//    self.muStr = [NSMutableString  stringWithFormat:@"Antony"];
    
//    ADLog(@"----- %@---%p",nameString,nameString);
//    ADLog(@"----- %@---%p",self.muStr,self.muStr);

    
//    崩溃-不可变不可appendString
//    [self.muStr appendString:@".Wong"];
    
//    ADLog(@"+++++++ %@---%p",nameString,nameString);
//    ADLog(@"+++++++ %@---%p",self.muStr,self.muStr);


    
    
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
    
    //    [self KeepAlive];

//    [self JDtest];
    
//    [self buttonBindSomething];

//        [self testButtonUI];
    
//    NSMutableArray *arr = @[@"0",@"1",@"2",@"0",@"1",@"3"].mutableCopy;
//    ADLog(@"%@",arr);
//    [self testGameV:arr];
//    ADLog(@"%@",arr);

    [self testMode];
}

- (void)testMode {
    
}
- (void)testGameV:(NSMutableArray *)arr {
//    safe
    for (int i=0; i<arr.count; i++) {
        if ([arr[i] isEqualToString:@"0"]) {
//            [arr removeObject:arr[i]];
            [arr removeObjectAtIndex:i];
        }
    }
    
    
//    ------- crash, was mutated while being enumerated，移除最后一个不会崩溃
//    for (NSString *str in arr) {
//        if ([str isEqualToString:@"0"]) {
//            [arr removeObject:str];
//        }
//    }
    
    
//    --------- safe
//    NSMutableArray *tempArr = [arr mutableCopy];
//    for (NSString *str in tempArr) {
//        if ([str isEqualToString:@"0"]) {
//            [arr removeObject:str];
//        }
//    }
    ADLog(@"%@",arr);
    
}
- (void)testButtonUI {
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    // 这样设置透明度会隐藏子视图，阻止事件响应性传递
//    view1.backgroundColor = UIColor.redColor;
//    view1.alpha = 0;
    // 这样设置透明度不会隐藏子视图
    view1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick1)];
    [view1 addGestureRecognizer:tap1];
//    [self.view addSubview:view1];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(10, 10, 50, 50);
    button1.backgroundColor = UIColor.yellowColor;
    [button1 addTargetSelected:^(UIButton * _Nonnull button) {
        ADLog(@"111");
    }];
    [view1 addSubview:button1];
    
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    view2.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:1];
    view2.userInteractionEnabled = NO;
    [view1 addSubview:view2];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(110, 10, 50, 50);
    button2.backgroundColor = UIColor.purpleColor;
    [button2 addTargetSelected:^(UIButton * _Nonnull button) {
        ADLog(@"222");
    }];
    [button2 addTargetSelected:^(UIButton * _Nonnull button) {
        ADLog(@"333");
    }];
    [self.view addSubview:button2];
    
}

- (void)tapClick1 {
    ADLog(@"tapClick1");
}
- (void)testNSLock {
    
//    打印000
    self.nsLock = [NSLock new];
    self.recursiveLock = [NSRecursiveLock new];
    
//    000  在同一个线程上两次调用lock方法将永久锁定线程
//    [self.nsLock lock];
//    ADLog(@"000");
//        [self.nsLock lock];
//        ADLog(@"111");
//        [self.nsLock unlock];
//    ADLog(@"222");
//    [self.nsLock unlock];
//    ADLog(@"333");    
    
    // 000 111 222 333
    [self.recursiveLock lock];
    ADLog(@"000");
        [self.recursiveLock lock];
        ADLog(@"111");
        [self.recursiveLock unlock];
    ADLog(@"222");
    [self.recursiveLock unlock];
    ADLog(@"333");
}

- (void)testAssign {
    // crash ,object will be released after assignment，当对象释放后（因为不存在强引用，离开作用域对象内存可能被回收），指针的地址还是存在的，也就是说指针并没有被置为nil,下次再访问该对象就会造成野指针异常
//    self.objc1 = [[objc1 alloc]init];
//    [self.objc1 run]; // 野指针异常
    
    objc1 *Tobjc1 = [[objc1 alloc]init];
    self.objc1 = Tobjc1;
    [self.objc1 run];
}

- (void)buttonBindSomething {

    for (int i=0; i<8; i++) {
       UIButton *testButton = [UIButton buttonWithType:UIButtonTypeSystem];
       testButton.frame = CGRectMake(100, 100 + 50*i, 30, 30);
       testButton.nameId = [NSString stringWithFormat:@"%d",i];
       testButton.backgroundColor = UIColor.redColor;
       [testButton addTarget:self action:@selector(testButtonClick:) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:testButton];
   }
}
- (void)testButtonClick:(UIButton *)sender {
    ADLog(@"按钮点击了-- ");
}
- (void)JDtest {
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(25, 25, 50, 50);
    button.backgroundColor = UIColor.blueColor;
    [button addTarget:self action:@selector(JDbuttonCliuck) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
   
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(JDtapClick)];
//    默认为YES。表示当手势识别器成功识别了手势之后，会通知Application取消响应链对事件的响应，并不再传递事件给hit-test view。
    tap.cancelsTouchesInView = NO; // JDbuttonCliuck 和 JDtapClick 都执行
    
    [view addSubview:button];
    [view addGestureRecognizer:tap];

//
//    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewtapClick)];
//    viewTap.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:viewTap];
    
    
}

- (void)viewtapClick {
    ADLog(@"------%s",__func__);
}
- (void)JDbuttonCliuck {
    ADLog(@"------%s",__func__);
}
- (void)JDtapClick {
    ADLog(@"------%s",__func__);
}
- (void)KeepAlive {
    
    self.actLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.actLabel.text = [NSString stringWithFormat:@"%d",self.count];
    self.actLabel.textColor = UIColor.redColor;
    [self.view addSubview:self.actLabel];
    
//    [CLTaskTimer execTask:^{
//
//        self.count ++;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            self.actLabel.text = [NSString stringWithFormat:@"%d",self.count];
//        });
//
//    } start:0 interval:1.0 repeats:YES async:YES];
    
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ADLog(@"点击屏幕");
    
//    @try {
//        NSArray *arr= @[@1,@2];
//        ADLog(@"%@",arr[3]);
//    } @catch (NSException *exception) {
//        ADLog(@"catch");
//    } @finally {
//        ADLog(@"finally");
//    }
    
    
//    @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:@"--- NSRangeException"] userInfo:nil];
    
//    [CLKeepAlive startLocation];
    
//    [self newMessageWarning:3 msgCount:5];

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
