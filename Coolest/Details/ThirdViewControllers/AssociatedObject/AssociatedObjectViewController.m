//
//  AssociatedObjectViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/5/16.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "AssociatedObjectViewController.h"
#import "AssociatedPerson.h"
#import <objc/runtime.h>

static char key;

@interface AssociatedObjectViewController ()

@end

@implementation AssociatedObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    AssociatedPerson *person = [AssociatedPerson new];
    person.name = @"Jack";
    person.vc = self;
    
//    ********* 会循环引用，无法释放，内存泄露
//    objc_setAssociatedObject(self, &key,person,OBJC_ASSOCIATION_RETAIN);
    
//    关联对象实现weak,
//    --------- 使用了一个weak 的局部变量 weakObj 来存储值. 并在 block 中将其捕获并返回.
//    由于 weakObj 是弱引用, 所以不会修改对象的引用计数. 当对象释放时, 由于 weakObj的 weak属性, 它也会在释放后指向nil. 所以在 getter 中返回的时候, 自然也是返回 nil.
    
    __weak typeof(person) weakPerson = person;
    AssociatedPerson *(^block) (void) = ^AssociatedPerson *(void) {
        return weakPerson;
    };

    objc_setAssociatedObject(self, &key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    ADLog(@"%s",__func__);
    
//    AssociatedPerson *person =objc_getAssociatedObject(self, &key);
//    ADLog(@"%@   -  %@",person.name,person.vc);

    AssociatedPerson *(^block)(void) =objc_getAssociatedObject(self, &key);
    AssociatedPerson *p = block();
    ADLog(@"%@   -  %@",p.name,p.vc);
    
//    objc_removeAssociatedObjects(self);

}

- (void)dealloc {
    ADLog(@"%s",__func__);
}

@end
