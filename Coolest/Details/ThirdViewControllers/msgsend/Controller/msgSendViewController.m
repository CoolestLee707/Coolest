//
//  msgSendViewController.m
//  Coolest
//
//  Created by daoj on 2018/11/29.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import "msgSendViewController.h"
#import "msgPerson.h"

@interface msgSendViewController ()

@property (nonatomic,copy) NSString *name;

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
    [msgPerson sendMessageClass:@"类方法"];
    
    msgPerson *person = [msgPerson alloc];
    [person run];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
