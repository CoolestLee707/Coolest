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

@end

@implementation WeakTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"weak";
   
    [self Test1];
    
//    [self Test2];

//    [self Test3];

//    [self Test4];
    
//    [self Test5];

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
        
        //        [[WeakManager shareInstance]openH5URLWithViewController:WeakSelf withURL:@"https://www.baidu.com"];
        
//        [WeakSelf gotoWebview:WeakSelf Url:@"https://www.baidu.com"];
        
        [WeakSelf goggoo];
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
    ADLog(@"___________");
}

@end
