//
//  WeakTestViewController.m
//  Coolest
//
//  Created by daoj on 2019/5/30.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "WeakTestViewController.h"
#import "weakTestView.h"
#import "WKWebviewViewController.h"

typedef void(^testBlock)(void);
typedef void(^secondBlock)(WeakTestViewController *vc);

@interface WeakTestViewController ()
{
   __weak UIViewController *controller;
    
    WeakManager *_manger;
    
//    NSString *_nameStr;
    
}

@property (nonatomic,strong) weakTestView *weakView;

@property (nonatomic,copy) testBlock tblock;
@property (nonatomic,copy) secondBlock sblock;

@property (nonatomic,copy) NSString *name;


//@property (nonatomic,copy) NSString *nameStr;
/**
 weak 弱引用的变量初始化后用临时变量指向要不就会释放，除非timer用scheduledTimerWithTimeInterval初始化后就加到runloop中不会释放
 */
@property (nonatomic,weak) NSTimer *timer;

@property (nonatomic,weak) UIView *weakView1;

@property (nonatomic,copy) NSString *namestr1;
@property (nonatomic,copy) NSString *namestr2;


@property (nonatomic,strong) NSArray *array;


@property (nonatomic, strong) NSString *strongString;
@property (nonatomic, weak)   NSString *weakString;


@end

@implementation WeakTestViewController
{
    NSString *_nameStr;
}
- (void)viewWillDisappear:(BOOL)animated
{
//    timer强弱都可以dealloc， 非block的timer要在这里invalidate
    [self.timer invalidate];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"weak";
    
//    _namestr1 = @"Cool";
//    ADLog(@"_namestr1 - %p ---- %p --- %p",_namestr1,&_namestr1,@"Cool");
//
//    self.namestr2 = @"Hot";
//    ADLog(@"self.namestr2 - %p ---- %p --- %p",self.namestr2,&_namestr2,@"Hot");
    
//    kWeakSelf(WeakSelf);
//self被WeakManager强引用，就不会delloc
//    [[WeakManager shareInstance]openH5URLWithViewController:self withURL:@"https://www.baidu.com"];

//    [self Test1];
    
//    [self Test2];

//    [self Test3];

//    [self Test4];
    
//    [self Test5];

//    [self Test6];
    
//    [self Test7];
//
//    if (self.weakView1 == nil) {
//           ADLog(@"viewDidLoad --- weakView1 被释放了");
//       }
    
//     [self Test8];
    
//    [self Test9];
    
//    [self Test10];
    
//    [self Test11];

//    [self Test12];
    
//    [self Test13];
    
//    NSString *str = @"http://192.168.138.203:8099/Info.json";
//
//    NSURL *url = [[NSURL alloc] initWithString:str];
//
//    NSString* jsonstring=[[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//
//    ADLog(@"%@",jsonstring);
    
//    [self test14];
    
    
    
    

}

- (void)test14 {
    NSMutableString *str = [NSMutableString stringWithFormat:@"123"];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    [arr addObject:str];
    
    ADLog(@"%p--- %@ --- %p",str,arr,arr[0]);
    
    str = nil;
    ADLog(@"%p--- %@ --- %p",str,arr,arr[0]);
}
- (void)Test13 {
    
    self.strongString =  [NSString stringWithFormat:@"%@",@"string1"];
    self.weakString =  self.strongString;
    self.strongString = nil;

    ADLog(@"%@", self.weakString);
}
- (void)Test12 {
    
    //指针指向的地址l存储的内容不可以变，但是指针可以指向别的地方
    const NSString *str1 = @"非酒水，发多少，辅导教师";
    //指针不能指向别的地方，指向的这个地方里面内容可以边
//    NSString * const str1 = @"非酒水，发多少，辅导教师";

    ADLog(@"%@ --- %p --- %p",str1,str1,&str1);
    str1 = @"fdjs sdfj  dsjs  dsfj ds g";
    ADLog(@"%@ --- %p --- %p",str1,str1,&str1);

//    NSString *str2 = str1;
//    ADLog(@"%@ --- %p --- %p",str2,str2,&str2);

}

- (void)Test11 {
    
    NSString* str1 = @"123";
    ADLog(@"str1 = %p, str1 = %@",str1,str1);
    NSString* str2 = @"123";
    ADLog(@"str2 = %p, str2 = %@",str2,str2);

    NSString* str3 = [[NSString alloc]initWithFormat:@"123"];
    ADLog(@"str3 = %p, str3 = %@",str3,str3);
    NSString* str4 = [[NSString alloc]initWithFormat:@"123"];
    ADLog(@"str4 = %p, str4 = %@",str4,str4);

    NSString* str5 = [[NSString alloc]initWithString:str3];
    ADLog(@"str5 = %p, str5 = %@",str5,str5);
    NSString* str6 = [[NSString alloc]initWithString:str3];
    ADLog(@"str6 = %p,str6 = %@",str6,str6);
    
    
    
}
- (void)Test10 {
    
    NSArray *array = @[@1, @2, @3, @4];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
       
    self.array = mutableArray;
    [mutableArray removeAllObjects];;
    ADLog(@"%@",self.array);

//    @property (nonatomic,strong) NSArray *array; 空
//    @property (nonatomic,copy) NSArray *array; 不空

}
- (void)Test9 {
    NSString *str1;
    NSString *str2 = nil;
    NSString *str3 = @"";
    ADLog(@"str1 -- %p---%p---%@",str1,&str1,str1);
    ADLog(@"str2 -- %p---%p---%@",str2,&str2,str2);
    ADLog(@"str3 -- %p---%p---%@",str3,&str3,str3);
}
- (void)Test8
{
    NSArray *arr = @[@"12321312313123123123123123131231232131232131221"];
    NSMutableArray *arr1 = [arr mutableCopy];
    [arr1 addObject:@"asdfsdfsfsfsfsfsfds"];
    
//    NSMutableArray *arr2 = [arr copy];
//    [arr2 addObject:@"asd"];
//    崩溃，copy浅拷贝，返回NSArray类型指针
    NSString *str = arr.firstObject;
    NSString *str1 = arr1.firstObject;

    ADLog(@"arr---%p --%p-- %p ----%p--%@",arr,&arr,&str,str,str);
    ADLog(@"arr1---%p --%p-- %p ----%p--%@",arr1,&arr1,&str1,str1,str);

//    不完全深拷贝，里面的内容还是同一个，存储在0x101393b08
//    arr---0x600002071890 --0x7ffeeeff8fc8-- 0x7ffeeeff8fb8 ----0x101393b08--12321312313123123123123123131231232131232131221
//    arr1---0x600002ce8090 --0x7ffeeeff8fc0-- 0x7ffeeeff8fb0 ----0x101393b08--12321312313123123123123123131231232131232131221
}
- (void)Test7
{
      
//   viewDidLoad --- weakView1 被释放了
//    ADLog(@"Test7 --- weakView1 被释放了");
//    两个都打印了，[[UIView alloc]init]执行完返回的指针被弱引用，在AutoreleasePool被释放了
//    self.weakView1 = [[UIView alloc]init];
    
    
    
//     viewDidLoad --- weakView1 被释放了
//    [UIView new]返回指针被保存在临时变量 UIView *view中，所以本方法执行完之前不会被释放，超过作用域就被释放

    UIView *view = [UIView new];
    
    self.weakView1 = view;
    
    if (self.weakView1 == nil) {
        ADLog(@"Test7 --- weakView1 被释放了");
    }
}
- (void)Test6
{
    // 创建 NSTimer
//    NSTimer *doNotWorkTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(outputLog:) userInfo:nil repeats:YES];
//    // NSTimer 加入 NSRunLoop
//    [[NSRunLoop currentRunLoop] addTimer:doNotWorkTimer forMode:NSDefaultRunLoopMode];
//    // 赋值给 weak 变量
//    self.timer = doNotWorkTimer;
  
    
//    weak-timer，为nil，strong-timer，不为nil
//    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(outputLog:) userInfo:nil repeats:YES];
    
    
    //weak-timer，不为nil
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(outputLog:) userInfo:nil repeats:YES];

//
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        ADLog(@"it is log!");
//    }];
    
    if (self.timer == nil) {
        ADLog(@"timer 被释放了");
    }
}

- (void)outputLog:(NSTimer *)timer{
    ADLog(@"it is log!");
}

- (void)Test5
{
    self.name = @"1111";
    
    self.sblock = ^(WeakTestViewController *vc) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            ADLog(@"%@",vc.name);
        });

    };
    
    self.sblock(self);
}

- (void)Test2
{
    self.name = @"1111";
    
    kWeakSelf(weakSelf);
    self.tblock = ^{
        
        weakSelf.name = @"22222";
        ADLog(@"%@",weakSelf.name);
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            ADLog(@"%@",weakSelf.name);//null,数据丢失
//        });
    };
    
    self.tblock();
    
    ADLog(@"self ---- %@",self.name);
    ADLog(@"weakSelf --- %@",weakSelf.name);

}

- (void)Test3
{
    self.name = @"1111";
    
    kWeakSelf(weakSelf);
//    __weak  typeof(self) weakSelf = self;
    
    self.tblock = ^{
        
        kStrongSelf(strongSelf, weakSelf);
//        __strong typeof(self) strongSelf = weakSelf;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            ADLog(@"%@",strongSelf.name);//执行完再dealloc
        });
    };
    
    self.tblock();
}

- (void)Test4
{
    self.name = @"1111";
    
    __block WeakTestViewController *vc = self;
    self.tblock = ^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            ADLog(@"%@",vc.name);
            vc = nil;
//            ARC下，__block修饰对象会被强引用，无法避免循环引用，需要手动释放，MRC下不会增加其引用计数，避免循环引用
        });
      
    };
    
    self.tblock();
}

- (void)Test1
{
    kWeakSelf(WeakSelf);
    
    self.weakView = [[weakTestView alloc]initWeakTestView];
//
    [self.view addSubview:self.weakView];

//    _manger = [[WeakManager alloc]init];
//    _manger.testVc = WeakSelf;
    
//    weakTestView *view = [[weakTestView alloc]initWeakTestView];
//    [self.view addSubview:view];  //self强持有view

    
//    局部变量
//    addSubview  ->  self强持有view   不会被释放
//    [self removeFromSuperview];//所有对其他对象的持有（强弱）都断掉

    
    self.weakView.touchBlock = ^(NSString * _Nonnull str) {
   
//        不加w__week:controller又被强引用不会释放走delloc
//                [[WeakManager shareInstance]openH5URLWithViewController:WeakSelf withURL:@"https://www.baidu.com"];
 
//        [WeakSelf gotoWebview:WeakSelf Url:@"https://www.baidu.com"];
        
//        [WeakSelf goggoo];
        
//        _nameStr = str;

//        ADLog(@"_nameStr   ------    %@",_nameStr);
        
    };
}
- (void)gotoWebview:(UIViewController *)vc Url:(NSString *)url
{
//    controller = vc;
    WKWebviewViewController* webvc = [[WKWebviewViewController alloc]init];
    webvc.webUrl = url;
    
    [controller.navigationController pushViewController:webvc animated:YES];
}

- (void)goggoo
{
    ADLog(@"121212");
}
- (void)dealloc
{
//    block的timer可以在这里invalidate
//    [self.timer invalidate];

    ADLog(@"___________%s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ADLog(@"%@", self.weakString);
}
@end
