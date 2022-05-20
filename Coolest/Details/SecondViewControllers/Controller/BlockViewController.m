//
//  BlockViewController.m
//  Coolest
//
//  Created by daoj on 2019/3/7.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "BlockViewController.h"
#import "PersonBlock.h"
#import "CMPerson.h"
#import "objc1.h"
#import "objc2.h"
#import "BlockTestObject.h"


@interface BlockViewController ()

@property (nonatomic,assign)NSInteger count;
@property (nonatomic,copy)NSString *name;


@property (nonatomic,strong) objc1 *ob1;
@property (nonatomic,strong) objc2 *ob2;

@property (nonatomic,weak) CMPerson *weakPerson;

// masonry 不会循环引用
@property(nonatomic,strong)BlockTestObject *obj1;
@property(nonatomic,copy)NSString *BlockTestName;

@end

@implementation BlockViewController

int(^CMBlock101) (int);


void (^testBlock)(void);

typedef void(^CMBlock) (void);

// block作为函数返回值时,在ARC环境下，编译器会根据情况自动将栈上的block复制到堆上
CMBlock test101 () {
    int a = 10;
    return ^{
        ADLog("a = %d",a);
    };
}
void test100() {
    int age = 10;
    testBlock = ^{
        ADLog(@"testBlock ----- %d",age);
    };
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Block";
    
    
//    masonry
//    [self testMasonry];
    
//    ADLog("-- %@",[ test101() class]);
    
//    int age = 10;
//    static NSString *abc = @"etqwetqiweyqwiubeqw";
//    NSMutableString *hj = [@"12yiuuiyviyuvbkug" mutableCopy];
    
//    void (^testBlock1)(void) = ^{
//
//        ADLog(@"testBlock ----- %@",abc);
//    };
//
//    abc = @"7837213712387120938712";
//    [hj appendString:@"11111111111111"];
    
//    testBlock1();
//
//    __block int age = 10;
//
//    void (^testBlock2)(void) = ^{
//
//        age = 20;
//        ADLog(@"testBlock ----- %d",age);
//    };
//
//    ADLog(@"testBlock ******** %d",age);
//
//    testBlock2();
//
//    ADLog(@"testBlock ++++++ %d",age);
//
//    ADLog(@"-- %@",[testBlock2 class]);
    
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
    
//    [self test12];
    
//    [self test14];
    
//    [self weakTest1];
    
//    [self weakTest2];

    [self aboutBlock];
}

- (void)aboutBlock {
    // 基本数据类型捕获的是值，所以修改不能影响外部的变量
    // 指针类型捕获的是指针，可以修改指针指向的值，但是不能修改指针
    // 以上两种类型，如果想修改外部变量（基本类型、指针类型）都需要使用__block修饰
    __block int a = 10;
    __block NSString *name = [NSString stringWithFormat:@"123abc"];
    __block NSMutableString *name1 = [NSMutableString stringWithFormat:@"123abc"];
    NSMutableString *name2 = [NSMutableString stringWithFormat:@"qqqq"];
    __block NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"3",@"4", nil];
    CMPerson *obj = [[CMPerson alloc]init];
    obj.age = @"1";
    void (^block)(NSDictionary *result) = ^(NSDictionary *result) {
        a = 20;
        name = [NSString stringWithFormat:@"123abcqqq"];
        name1 = [NSMutableString stringWithFormat:@"123abcwww"];
        name2.string = @"wwwww";//没有__block:使用可以，修改不可以
        [arr addObject:@"5"];
        arr = [NSMutableArray arrayWithObjects:@"8",@"9", nil];
        NSLog(@"block arr == %@",arr);
        obj.age = @"123"; //不是修改obj，使用obj
    };
    block(@{@"key": @"123"});
}

- (void)testMasonry {
    self.name = @"Jock";
    self.obj1 = [BlockTestObject new];
    
//    不会循环引用，都会的dealloc
//    [self.obj1 testMethod:^{
//        ADLog(@"self.name - %@",self.name);
//    }];

//    会循环引用，都不会的dealloc
    [self.obj1 testMethodSave:^{
        ADLog(@"self.name - %@",self.name);
    }];
}
- (void)weakTest2 {
    
    self.weakPerson = [[CMPerson alloc] init];
    self.weakPerson.age = @"111";
    ADLog(@"%@",self.weakPerson.age);
    
    __block int a = 11;
    testBlock = ^{
        self.weakPerson.age = @"222";
        a = 22;
        ADLog(@"--- %@ --- %d",self.weakPerson.age,a);

    };
    a = 33;
    self.weakPerson.age = @"333";
    ADLog(@"--- %@ --- %d",self.weakPerson.age,a);

    testBlock();
}

- (void)weakTest1 {
    
    __weak CMPerson *cmPerson = [[CMPerson alloc] init];
    cmPerson.age = @"111";
    ADLog(@"%@",cmPerson.age);
    
    __block int a = 11;
    testBlock = ^{
        cmPerson.age = @"222";
        a = 22;
        ADLog(@"--- %@ --- %d",cmPerson.age,a);

    };
    a = 33;
    cmPerson.age = @"333";
    ADLog(@"--- %@ --- %d",cmPerson.age,a);

    testBlock();
}
- (void)test14 {
    
    __block int a = 10;
    CMBlock101 = ^int(int number) {
        return a*number;
    };
    a = 20;
    [self test14Method];
}
- (void)test14Method {
    ADLog(@"%d",CMBlock101(3));
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
    
    ADLog(@"globalBlock - %@ - %@",[globalBlock class],^{
    });
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

- (void)test12 {
    
    NSMutableArray * arr = @[@"1",@"2"].mutableCopy;
    
    ADLog(@"arr 1111111 %@ 11111111 %p",arr,arr);

    void(^block12)(void) = ^ {
        
        ADLog(@"arr --- %@ --- %p",arr,arr);
        [arr addObject:@"4"];
        ADLog(@"arr +++ %@",arr);
    };
    
    [arr addObject:@"3"];
    ADLog(@"arr 3333333 %@ 33333333 %p",arr,arr);

    arr = nil;
    block12();
    
    ADLog(@"arr ==== %@ ===== %p",arr,arr);

}
@end
