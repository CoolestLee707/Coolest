//
//  msgSendViewController.m
//  Coolest
//
//  Created by daoj on 2018/11/29.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import "msgSendViewController.h"
#import "msgPerson.h"
#import "msgDog.h"
#import "msgCat.h"
#import "msgKit.h"

@interface msgSendViewController ()

@property (nonatomic,copy) NSString *name;
@property (atomic,copy) NSString *atomicName;
@property (nonatomic,strong) msgPerson *person;
@property (nonatomic,strong) msgDog *dog;
@property (nonatomic,strong) msgCat *cat;
@property (nonatomic,strong) msgKit *kit;

@end

@implementation msgSendViewController

@synthesize name = _coolName;

- (void)viewDidLoad {
    [super viewDidLoad];
    _coolName = @"e44";
    self.title = @"消息转发处理";

    //实例方法
//    [[msgPerson new] sendMessageInstance:@"Hello World"];
    
    //类方法
//    [msgPerson sendMessageClass:@"类方法"];
    
//    msgPerson *person = [msgPerson alloc];
//    [person run];
    
//    synthesize
//    self.cat = [msgCat new];
//    self.cat.name = @"kit";
    
//    self.kit = [msgKit new];
//
//    self.dog = [msgDog new];
//    [self.dog eat];
    
   
}

- (void)testAtomic {
    
//    nonatomic 多线程setter，一个对象对次release崩溃，对NSArray容器使用时无法保证线程安全
    for (int i=0; i<1000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.atomicName = [NSString stringWithFormat:@"hdaskh jkdhasjkdhakdh kajshdkljsahd ksal %d",i];
        });
    }
    ADLog(@"self.name - %@",self.atomicName);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.person = [msgPerson new];
//    [self.person sendMessageInstance:@"Hello World"];
//
//    ADLog(@"%@",self.cat.name);
//
//
//    self.cat.name = [NSString stringWithFormat:@"%@ - ",self.cat.name];
    
//    [self.kit run];
    
    NSDictionary *jsonDic = @{
        @"personName" : @"000",
        @"kitName" : @"111",
    };
    self.person = [msgPerson new];
    [self.person setValuesForKeysWithDictionary:jsonDic];
    
//    self.kit = [msgKit new];
//    [self.kit setValuesForKeysWithDictionary:jsonDic];
    
    
}
@end
