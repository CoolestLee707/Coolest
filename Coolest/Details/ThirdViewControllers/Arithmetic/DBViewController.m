//
//  DBViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/7/15.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "DBViewController.h"
#import "NSObject+DLIntrospection.h"


typedef NS_ENUM(NSUInteger, DBType) {
    DBTypeDev,       // 开发
    DBTypeTest,      // 测试
    DBTypeSandbox,   // 沙箱
    DBTypeProd       // 线上
};



@interface DBViewController ()
- (void)eat;
@end

@implementation DBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"算法1";

    [self isEqualString];
       
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
