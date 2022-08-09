//
//  DBViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/7/15.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "DBViewController.h"
#import "NSObject+DLIntrospection.h"
#import "CLOrderDictionary.h"

#import <CMtestSDK/CoolTest.h>

#import <SDKPod/SDKPod.h>

typedef NS_ENUM(NSUInteger, DBType) {
    DBTypeDev,       // 开发
    DBTypeTest,      // 测试
    DBTypeSandbox,   // 沙箱
    DBTypeProd       // 线上
};



@interface DBViewController ()

@property (nonatomic,strong) CLOrderDictionary *CLDic;
@property (nonatomic,strong) UIView *v1;
@property (nonatomic,strong) UIView *v2;
@property (nonatomic,strong) UIView *bgView;
//类扩展中申明的方法没有被实现，编译器会报警
- (void)eat;

@end

@implementation DBViewController

- (CLOrderDictionary *)CLDic {
    if (!_CLDic) {
        _CLDic = [[CLOrderDictionary alloc]init];
    }
    return _CLDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"DBViewController";
    
//   NSHashTable
    
//    [self isEqualString];
       
//    [self function_0];
       
//    [self function_1];
    
//    [self function_2];
    
//    [self function_3];

//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 30, 30)];
//    view.backgroundColor = UIColor.blackColor;
//    [self.view addSubview:view];
//
//    UIViewController *vc = [self getControllerFromView:view];
//
//    ADLog(@"%@-%p",vc,vc);
    
//    [self testMethod];
    
    
//    [self NSHashTable];
    
//    [self testBounds];
    
//    [self testOrderSet];
    
//    [self testKK];
    
//    [self testString1];
    
//    [self testString2];

    
//    [self testKKK];
    
 
    [self testSDK];
    
    [self testSDKPod];

}

- (void)testSDK {

    CoolTest *sdk = [[CoolTest alloc]init];
    NSString *str = [sdk factoryCoolTest];
    NSLog(@"%@",str);
}


- (void)testSDKPod {
    SpriteFactory *sdk = [[SpriteFactory alloc]init];
    NSString *str = [sdk cerateNewGoods:@"123"];
    NSLog(@"%@",str);
}


- (void)testKKK {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 100, 50, 40);
    button.backgroundColor = UIColor.grayColor;
    [button addTargetSelected:^(UIButton * _Nonnull button) {
        [self testKK];
    }];
        
    UIView *bgView = [UIView new];
    bgView.backgroundColor = UIColor.redColor;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.leading.mas_equalTo(100);
    }];
    
    [bgView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.width.height.mas_equalTo(50);
    }];
    
//    bgView.clipsToBounds = YES;
    
    
    
//    [self testStringPerform:YES];
//    objc_msgSend(self, @selector(testStringPerform:),NO);
//    [self performSelector:@selector(testStringPerform:) withObject:@YES];
    
//    [self performSelector:@selector(testStringPerformStr:) withObject:@"121212"];
}
- (void)testStringPerform:(BOOL)isOk {
    if (isOk) {
        NSLog(@"isOk");
    }else {
        NSLog(@"isFail");
    }
}

- (void)testStringPerformStr:(NSString *)isOkStr {
    NSLog(@"%@",isOkStr);
}

- (void)testString1 {
    //    crash testStr : NSString  1
//    1218hkjdh0duouklmskldj88xnkjndsjdh89xi 在静态区 0x108b05dd0
    NSMutableString *testStr = [NSMutableString string];
    testStr = @"1218hkjdh0duouklmskldj88xnkjndsjdh89xi";
    NSLog(@"%@ - %p",testStr,testStr);
   
    [testStr appendString:@"aaaaa"];
    NSLog(@"%@",testStr);
}

- (void)testString2 {
    //    crash testStr : NSString  1
    //    1218hkjdh0duouklmskldj88xnkjndsjdh89xi 在堆区 0x6000022101c0
    NSMutableString *testStr = [NSMutableString string];
    
//  testStr 变成 NSString 类型
    testStr = [NSString stringWithFormat:@"1218hkjdh0duouklmskldj88xnkjndsjdh89xi"];
    
    NSLog(@"%@ - %p",testStr,testStr);
    [testStr appendString:@"aaaaa"];
    NSLog(@"%@",testStr);
}



- (void)testKK {
    self.v1 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.v1.backgroundColor = UIColor.redColor;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(v1Hidden)];
    [self.v1 addGestureRecognizer:tap1];
    [[UIApplication sharedApplication].keyWindow addSubview:self.v1];
  
    self.v2 = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    self.v2.backgroundColor = UIColor.blueColor;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(v2Hidden)];
    [self.v2 addGestureRecognizer:tap2];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    self.bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    
    [self.bgView addSubview:self.v1];
    [self.bgView addSubview:self.v2];

    self.v1.hidden = YES;
    
}
- (void)v1Hidden {
//    self.v1.hidden = YES;
    [self.v1 removeFromSuperview];
    [self.bgView removeFromSuperview];
}

- (void)v2Hidden {
//    self.v2.hidden = YES;
    [self.v2 removeFromSuperview];
    self.v1.hidden = NO;
}


// 设计一个key是有序的字典
- (void)testOrderSet {
    
    //    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    //    for (int i=0; i<100; i++) {
    //        [tempDic setValue:[NSString stringWithFormat:@"--- %d",i] forKey:[NSString stringWithFormat:@"%d",i]];
    //    }
    //    NSLog(@"%@",tempDic);  // 无序
        
        
    for (int i=0; i<100; i++) {
        [self.CLDic CLSetValue:[NSString stringWithFormat:@"+++ %d",i] forKey:[NSString stringWithFormat:@"%d",i]];
    }
    NSLog(@"+++= %@",[self.CLDic CLvalueOfIndex:10]); // 有序访问
    [self.CLDic CLSetValue:@"XXX" atIndex:10]; // 有序修改
    
    NSLog(@"self.CLDic - %@",self.CLDic.CLallKeys);  // 有序
}


// scrollView通过修改bounds的x或y来实现滚动效果
- (void)testBounds {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    bgView.backgroundColor = UIColor.redColor;
    [self.view addSubview:bgView];
    
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, 20, 20)];
    subView.backgroundColor = UIColor.greenColor;
    [bgView addSubview:subView];
    
    
    [UIView animateWithDuration:3.0 animations:^{
        bgView.bounds = CGRectMake(0, 50, 100, 100);
    }];
}


- (void)NSHashTable {
    NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsCopyIn];
    [hashTable addObject:@"foo"];
    [hashTable addObject:@"bar"];
    [hashTable addObject:@42];
    [hashTable removeObject:@"bar"];
    NSLog(@"Members: %@", [hashTable allObjects]);
}

//performSelector是运行时系统负责去找方法的，在编译时候不做任何校验；如果直接调用编译是会自动校验,所以有时候如果使用了performSelector，为了程序的健壮性，会使用检查方法- (BOOL)respondsToSelector:(SEL)aSelector; 如果在子线程延迟执行要开启对应的RunLoop1

// 2.performSelector可以不用import头文件包含方法的对象，直接用performSelector调用，字符串映射

- (void)testMethod {
//    [self noMethod];
    SEL sel = NSSelectorFromString(@"noMethod");
    [self performSelector:sel];
}

//Equal,当使用==来判断两个变量是否相等的时候，如果是基本类型变量，且都是数值型（类型可以不同）,则只要值相等，就会返回真；
//如果是两个指针类型变量【例如OC对象】，则必须是两个指针变量保存的内存地址相同才会返回真
- (void)isEqualString {
    
    NSString *firstStr = @"helloworld";     // 字符串常量区 Equal
    NSString *secondStr = @"helloworld";    // 字符串常量区 Equal
    NSString *str3 = [NSString stringWithFormat:@"helloworld"];     // 堆区，Not Equal
    NSString* str4 = [NSString stringWithFormat:@"helloworld"];     // 堆区，Not Equal
    
    NSLog(@"%p-%p",firstStr,&firstStr);   // 0x105b30dd0-0x7ff7babfa978
    NSLog(@"%p-%p",secondStr,&secondStr); // 0x105b30dd0-0x7ff7babfa970
    NSLog(@"%p-%p",str3,&str3);           // 0x6000024b4c80-0x7ff7babfa968
    NSLog(@"%p-%p",str4,&str4);           // 0x6000024b4d20-0x7ff7babfa960
    
    if (firstStr == secondStr) {
        NSLog(@"== Equal");  // Equal
    } else {
        NSLog(@"== Not Equal");
    }
    
    if (firstStr == str3) {
        NSLog(@"== Equal");
    } else {
        NSLog(@"== Not Equal"); // Not Equal
    }
    
    if (str3 == str4) {
        NSLog(@"== Equal");
    } else {
        NSLog(@"== Not Equal"); // Not Equal
    }
    
    if ([firstStr isEqual:secondStr]) {
        NSLog(@"isEqual - Equal");  // Equal
    } else {
        NSLog(@"isEqual - Not Equal");
    }
    
    if ([firstStr isEqual:str3]) {
        NSLog(@"isEqual - Equal");  // Equal
    } else {
        NSLog(@"isEqual - Not Equal");
    }
    
    
    if ([str3 isEqual:str4]) {
        NSLog(@"isEqual - Equal");  // Equal
    } else {
        NSLog(@"isEqual - Not Equal");
    }
    
    ADLog(@"%@",[NSString parentClassHierarchy]);
//    这个方法是NSObject类提供的一个实例方法，因此，所有指针变量都可以调用该方法来判断是否与其他指针变量相等。但这个方法判断两个对象相等的标准与“==”符号没有区别，同样要求两个指针变量指向同一个对象才会返回真
//    不过需要特别提到的是NSString已经重写了NSObject的“isEqual”方法，判断标准不再是两个指针变量保存的内存地址相同返回真，而是只要两个字符串包含的字符序列相同就会返回真，否则假
  
    
    NSObject *obj1 = [NSObject new];
    NSObject *obj2 = [NSObject new];

    if (obj1 == obj2) {
        NSLog(@"NSObject == Equal");
    } else {
        NSLog(@"NSObject == Not Equal"); // Not Equal
    }
    
    if ([obj1 isEqual:obj2]) {
        NSLog(@"NSObject - isEqual - Equal");
    } else {
        NSLog(@"NSObject - isEqual - Not Equal");  // Not Equal
    }
}

- (void)function_0
{
    NSMutableArray *array_1 = [NSMutableArray array];
    __block NSMutableArray *array_2 = nil;
    void (^bar)(void) = ^{
        [array_1 addObject:@1];
        array_2 = array_1;
    };
    bar();
    
    NSLog(@"%@, %@", array_1, array_2);
}

//0,2,3,
//3 是修改指针指向的内存的值为3，不是修改指针指向
- (void)function_1 {
    NSInteger foo_1 = 0;
    __block NSInteger foo_2 = 0;
    NSInteger *foo_3 = (NSInteger *)malloc(sizeof(NSInteger));
    
    void (^bar)(void) = ^{
//       foo_1 = 1;
       foo_2 = 2;
       *foo_3 = 3;
    };
    bar();
    
    NSLog(@"%@, %@, %@", @(foo_1), @(foo_2), @(*foo_3));
}

// 1
- (void)function_2 {
    static NSInteger foo_1 = 0;
    
    void (^bar)(void) = ^{
       foo_1 = 1;
    };
    bar();
    
    NSLog(@"%@", @(foo_1));
}

// 1
NSInteger global_foo_1 = 0;
- (void)function_3 {

    void (^bar)(void) = ^{
       global_foo_1 = 1;
    };
    bar();
    
    NSLog(@"%@", @(global_foo_1));
}
// UIApplication、UIView、UIViewController这几个类是直接继承自UIResponder,所以这些类都可以响应事件
- (UIViewController *)getControllerFromView:(UIView *)view {
    // 遍历响应者链。返回第一个找到视图控制器
    UIResponder *responder = view;
    while ((responder = [responder nextResponder])){
        if ([responder isKindOfClass: [UIViewController class]]){
            return (UIViewController *)responder;
        }
    }
    // 如果没有找到则返回nil
    return nil;
    
    
//    UIResponder *re = view;
//    while (re) {
//        if ([re isKindOfClass: [UIViewController class]]){
//            return (UIViewController *)re;
//        }
//        re = [view nextResponder];
//    }
    
    
}

@end
