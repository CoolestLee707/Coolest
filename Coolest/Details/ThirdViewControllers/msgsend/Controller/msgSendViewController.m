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

#import "CMProxy.h"
#import "CMObject.h"

@interface msgSendViewController ()

@property (nonatomic,copy) NSString *name;
@property (atomic,copy) NSString *atomicName;
@property (nonatomic,strong) msgPerson *person;
@property (nonatomic,strong) msgDog *dog;
@property (nonatomic,strong) msgCat *cat;
@property (nonatomic,strong) msgKit *kit;

@property (nonatomic,strong) CMProxy *cmProxy;
@property (nonatomic,strong) CMObject *cmObject;

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
    
//    [self testAtomic];
    
    [self testProxy];
}


//通过继承自NSObject的代理类是不会自动转发respondsToSelector:和isKindOfClass:这两个方法的, 而继承自NSProxy的代理类却是可以的
- (void)testProxy {
    
    NSString *string = @"test";

    CMProxy *proxyA = [[CMProxy alloc] initWithObject:string];

    CMObject *proxyB = [[CMObject alloc] initWithObject:string];

    ADLog(@"%d", [proxyA respondsToSelector:@selector(length)]); // 1

    ADLog(@"%d", [proxyB respondsToSelector:@selector(length)]); // 0

    ADLog(@"%d", [proxyA isKindOfClass:[NSString class]]); // 1

    ADLog(@"%d", [proxyB isKindOfClass:[NSString class]]); // 0
    
    
//    CMProxy *proxyA = [[CMProxy alloc] initWithObject:self];
//    CMObject *proxyB = [[CMObject alloc] initWithObject:self];
//    [proxyA testAtomic];
//    [proxyB testAtomic];

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
