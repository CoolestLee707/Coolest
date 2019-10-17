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
}

@property (nonatomic,strong) weakTestView *weakView;

@property (nonatomic,copy) testBlock tblock;
@property (nonatomic,copy) secondBlock sblock;

@property (nonatomic,copy) NSString *name;



/**
 weak 弱引用的变量初始化后用临时变量指向要不就会释放，除非timer用scheduledTimerWithTimeInterval初始化后就加到runloop中不会释放
 */
@property (nonatomic,weak) NSTimer *timer;

@property (nonatomic,weak) UIView *weakView1;

@end

@implementation WeakTestViewController

- (void)viewWillDisappear:(BOOL)animated
{
//    timer强弱都可以dealloc， 非block的timer要在这里invalidate
    [self.timer invalidate];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"weak";
    
    
//    kWeakSelf(WeakSelf);
//self被WeakManager强引用，就不会delloc
//    [[WeakManager shareInstance]openH5URLWithViewController:self withURL:@"https://www.baidu.com"];

//    [self Test1];
    
//    [self Test2];

//    [self Test3];

//    [self Test4];
    
//    [self Test5];

//    [self Test6];
    
    [self Test7];

    if (self.weakView1 == nil) {
           ADLog(@"viewDidLoad --- weakView1 被释放了");
       }
}

- (void)Test7
{
      
//   viewDidLoad --- weakView1 被释放了
//    ADLog(@"Test7 --- weakView1 被释放了");
//    两个都打印了，[[UIView alloc]init]执行完返回的指针被弱引用，在AutoreleasePool被释放了
//    self.weakView1 = [[UIView alloc]init];
    
    
    
//     viewDidLoad --- weakView1 被释放了
//    [UIView new]返回指针被保存在临时变量 UIView *view中，所以本方法执行完之前不会被释放，超过作用于就被释放

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
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ADLog(@"%@",weakSelf.name);//null,数据丢失
        });
    };
    
    self.tblock();
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
        });
      
    };
    
    self.tblock();
}

- (void)Test1
{
    self.weakView = [[weakTestView alloc]initWeakTestView];
    
    [self.view addSubview:self.weakView];
    
    kWeakSelf(WeakSelf);
    
    self.weakView.touchBlock = ^{
//        不加w__week:controller又被强引用不会释放走delloc
                [[WeakManager shareInstance]openH5URLWithViewController:WeakSelf withURL:@"https://www.baidu.com"];
        
//        [WeakSelf gotoWebview:WeakSelf Url:@"https://www.baidu.com"];
        
//        [WeakSelf goggoo];
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

    ADLog(@"___________");
}

@end
