//
//  BlockViewController.m
//  Coolest
//
//  Created by daoj on 2019/3/7.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "BlockViewController.h"
#import "PersonBlock.h"

#import "objc1.h"
#import "objc2.h"

@interface BlockViewController ()

@property (nonatomic,assign)NSInteger count;
@property (nonatomic,copy)NSString *name;


@property (nonatomic,strong) objc1 *ob1;
@property (nonatomic,strong) objc2 *ob2;


@end

@implementation BlockViewController

void (^testBlock)(void);

void test100()
{
    int age = 10;
    testBlock = ^{
        ADLog(@"testBlock ----- %d",age);
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Block";
    
//    int age = 10;
    static NSString *abc = @"etqwetqiweyqwiubeqw";
//    NSMutableString *hj = [@"12yiuuiyviyuvbkug" mutableCopy];
    
    void (^testBlock1)(void) = ^{
        
        ADLog(@"testBlock ----- %@",abc);
    };
    
    abc = @"7837213712387120938712";
//    [hj appendString:@"11111111111111"];
    testBlock1();
    
    __block int age = 10;
    
    void (^testBlock2)(void) = ^{
        
        age = 20;
        ADLog(@"testBlock ----- %d",age);
    };
    
    ADLog(@"testBlock ******** %d",age);

    testBlock2();
    
    ADLog(@"testBlock ++++++ %d",age);

    ADLog(@"-- %@",[testBlock2 class]);
    
//    test100();
//
//    testBlock();
    
    
//    [self createGlobalBlock];
//
//    [self createMallocBlock];
//
//    [self createStackBlock];
    
//    [self testBlock];
    
//    [self PersonBlock1];
    
//    [self PersonBlock2];

    
//    void (^globalBlock) (void) = ^{
//        ADLog(@"block");
//    };
//
//    globalBlock();
//
//    ADLog(@"globalBlock - %@",globalBlock);
    
    
//    [self test11];
    
//    block 当做参数
//    [self testBlockParameter:^NSString *(NSString *str1, NSString *str2) {
//        NSString *str3 = [NSString stringWithFormat:@"%@-%@",str1,str2];
//        return str3;
//    }];
    
    
}
- (void)dealloc
{
    
}
//静态Block
int age = 10;
- (void)createGlobalBlock
{
//    static int age = 10;
    void (^globalBlock) (void) = ^{
        ADLog(@"block-%d",age);
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


- (void)PersonBlock1
{
    PersonBlock *person = [[PersonBlock alloc]init];
    [[person run1] study1];
    
//    [person.run1 study1];

}

- (void)PersonBlock2
{
    PersonBlock *person = [[PersonBlock alloc]init];
    
    //目标
//    person.runBlock().studyBlock().runBlock();

    
//    person.chooseBlock = ^NSString * _Nonnull(NSInteger number) {
//
//    }
    
//    person.run2().study2();
    
    person.run3(@"cool").study3(@"coder");

}


/// block 当做参数，两个传入参数，一个返回参数
- (void)testBlockParameter:(NSString *(^)(NSString *str1,NSString *str2))complete {

//    NSString *strq = !complete?nil:complete(@"111",@"222");
    
    if (complete) {
        NSString *str = complete(@"1",@"2");
        ADLog(@"str---%@",str);
    }
    
}


- (void)test11
{
    self.ob1 = [[objc1 alloc]init];
    self.ob2 = [[objc2 alloc]init];
    
    self.ob1.ob2 = self.ob2;
    
    [self.ob1 run];
    [self.ob2 run2];

    [self.ob1 run12];

    [self.ob1.ob2 run2];
}
@end
