//
//  BlockViewController.m
//  Coolest
//
//  Created by daoj on 2019/3/7.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Block";
    
//    [self createGlobalBlock];
    
    [self createMallocBlock];

//    [self createStackBlock];
    
    [self testBlock];

}

//静态Block
- (void)createGlobalBlock
{
    void (^globalBlock) (void) = ^{
        ADLog(@"block");
    };
    
    globalBlock();
    
    ADLog(@"globalBlock - %@",globalBlock);
}

//堆Block
- (void)createMallocBlock
{
    
    //引入外部变量变成NSMallocBlock
    //==  ->栈 copy到 堆
    
   __block int a = 0;
    
    //__block 把观察到的变量从栈 copy到 堆；栈空间比较小:2M
    
//    进入block前 --- 0x7ffee4e0e408
//    进入block后 --- 0x6000010f0ef8
//    进入block中 --- 0x6000010f0ef8
    
    ADLog(@"进入block前 --- %p",&a);
    
    
//    没有__block修饰把变量从栈拷贝到堆，传递过来的变量是值，block中不可修改，外部修改的还是栈中的变量，
//    有__blockd修饰的拷贝进来后，传递过来的是地址（指针），block内部外部可修改，都是堆中的变量
    void (^mallocBlock) (void) = ^{
        
        ADLog(@"进入block中 --- %p",&a);
        a++;
        ADLog(@"%d",a);
    };
    
    a++;
    ADLog(@"进入block后 --- %p",&a);

    mallocBlock();
    
    ADLog(@"mallocBlock - %@",mallocBlock);
}

//栈Block   ^{
//     ADLog(@"%d",a);
//   }
- (void)createStackBlock
{
    int a = 0;
//    void (^stackBlock) (void) = ^{
//    };
//    stackBlock();
    
    NSLog(@"stackBlock - %@",^{
        ADLog(@"%d",a);
    });
}


- (void)testBlock
{
    [self testBlock:^NSString *(NSString *result) {
        
        ADLog(@"%@",result);
        
        return @"block返回值";
    }];
}

- (void)testBlock:(NSString *(^)(NSString *result))complete {
    
    NSString *str = complete(@"block入参");
    ADLog(@"%@",str);
}

@end
