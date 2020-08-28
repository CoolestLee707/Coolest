//
//  KVOViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2020/6/19.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "KVOViewController.h"
#import "KVO_Person.h"
@interface KVOViewController ()

@property (nonatomic, strong) KVO_Person *person;


@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"KVO";

    self.person = [KVO_Person new];
    self.person.age = 10;
    
//    给对象添加监听age属性
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person addObserver:self forKeyPath:@"age" options:options context:@"上下文options"];
    
//    KVC方法调用KVO
    [self.person addObserver:self forKeyPath:@"name" options:options context:@"上下文options"];

//    po self.person.isa
//    NSKVONotifying_KVO_Person
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.person.age = 20;
//    for (int i=0; i<10; i++) {
//        self.person.age = i;
//    }
    [self.person setValue:@"cool" forKey:@"name"];
}

//当监听对象的属性发生改变时就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    ADLog(@"-%@\n-%@\n-%@\n-%@\n",keyPath,object,change,context);
}

//移除监听
- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"age"];
}
@end

