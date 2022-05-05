//
//  CrashViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2020/10/21.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "CrashViewController.h"
#import "CMPerson.h"

/*
 @try@catch
 OC语言存在异常机制，可以通过@try@catch来捕获异常，但这种方式不推荐大家去使用，并且实际开发过程中也很少存在使用此方式的情况。究其原因是：OC的异常捕获机制效率不高，且存在内存泄露的情况。
 @try@catch基于block处理会存在额外的开销，效率不高；
 Xcode默认不会对@try@catch中的代码进行ARC管理，如果在抛出异常代码后存在内存释放的话，就需要异常捕获后手动释放，否则就会导致内存泄露；
 但这个不能完全否定异常捕获的作用，在一些容易出现异常的操作上，比如文件读写或者需要配合使用@throw的情况等，这里指的不适合是针对大范围使用@try@catch捕获并不适合。
 */

@interface CrashViewController ()

@property (nonatomic,strong)CMPerson *person;

@end

@implementation CrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"崩溃处理";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = UIColor.redColor;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
   
}
- (void)buttonClick {
    
//    NSException *exception = [NSException exceptionWithName:@"name" reason:@"reason" userInfo:nil];
//    @throw exception;
    
    NSArray *arr = @[@"1",@"2",@"3"];
    @try {
        NSString *string = arr[3];
        ADLog(@"%@",string);
    } @catch (NSException *exception) {
        self.person = [CMPerson new];

    } @finally {
        
    }
}


- (void)testTryCche {
    
    
//    @try {
//        [self performSelector:@selector(buttonBindSomethingqqq)];
//    } @catch (NSException *exception) {
//        ADLog(@"%@",exception);
//
//    } @finally {
//        ADLog(@"finally");
//
//    }
    
    NSArray *arr = @[@"1",@"2",@"3"];
    @try {
        NSString *string = arr[3];
        ADLog(@"%@",string);
    } @catch (NSException *exception) {
        ADLog(@"%@",exception);
    } @finally {
        ADLog(@"finally");
    }
    ADLog(@"end");
}

@end
