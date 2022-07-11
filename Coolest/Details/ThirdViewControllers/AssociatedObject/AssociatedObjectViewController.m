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
static char keyBlock;

@interface AssociatedObjectViewController ()

@property (nonatomic,strong)AssociatedPerson *StrongPerson;

@property (nonatomic,assign)AssociatedPerson *assPerson;

@end

@implementation AssociatedObjectViewController

__weak id referenceObject = nil;
__weak id referenceStr = nil;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ADLog(@"%@ - %@",referenceObject,referenceStr);  // (null) - lcmdsdsjlsdjljdklsjdlksjds
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    ADLog(@"%@ - %@",referenceObject,referenceStr);  // (null) - (null)
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    AssociatedPerson *person = [AssociatedPerson new];

//    self.assPerson = [AssociatedPerson new];
    
    
//    @autoreleasepool {
//        AssociatedPerson *person = [AssociatedPerson new];
//        referenceObject = person;
//
//        NSString *str = [NSString stringWithFormat:@"lcmdsdsjlsdjljdkl5678sjdlksjds"];
//        referenceStr = str;
//    }
//    ADLog(@"%@ - %@",referenceObject,referenceStr);   // (null) - (null)
    
    
    
    AssociatedPerson *person = [AssociatedPerson new];
    // referenceObject是一个autorelease对象，设置一个weak的引用来观察它
    referenceObject = person;

    NSString *str = [NSString stringWithFormat:@"lcmdsdsjlsdjljdkl5678sjdlksjds"];
    referenceStr = str;
 
    
    ADLog(@"%p - %p",referenceObject,referenceStr);
    
    
//    [self test1];
//    [self test2];
    

}

- (void)test2 {
    
    self.StrongPerson = [AssociatedPerson new];
    [self.StrongPerson setAss:self];
    
}
- (void)test1 {
    
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
 //        __weak typeof(weakPerson) StrongPerson = weakPerson;
         return weakPerson;
     };
     
 //   循环引用
//     objc_setAssociatedObject(self, &key, person, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 //  不会循环引用
     objc_setAssociatedObject(self, &keyBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    ADLog(@"%s",__func__);
    
//    AssociatedPerson *person =objc_getAssociatedObject(self, &key);
//    ADLog(@"%@   -  %@",person.name,person.vc);

    AssociatedPerson *(^block)(void) =objc_getAssociatedObject(self, &keyBlock);
    AssociatedPerson *p = block?block():nil;
    ADLog(@"%@   -  %@",p.name,p.vc);
    
    objc_removeAssociatedObjects(self);
    
    
//    test 2
//    [self.StrongPerson removeAss:self];

}

- (void)dealloc {
    ADLog(@"%s",__func__);
}

@end
