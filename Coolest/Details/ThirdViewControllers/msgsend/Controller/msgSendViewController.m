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
    
    self.kit = [msgKit new];
    
    self.dog = [msgDog new];
    [self.dog eat];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
