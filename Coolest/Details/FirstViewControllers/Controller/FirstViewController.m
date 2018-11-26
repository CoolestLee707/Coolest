//
//  FirstViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "FirstViewController.h"
#import "RunLoopObject1.h"
#import "NSString+Hash.h"
#import "person.h"

@interface FirstViewController ()

@property (nonatomic,copy)NSString *firstName;

@property (nonatomic,strong)UIImageView *imageView;


@property (nonatomic, strong) NSString *strongString;
@property (nonatomic, copy) NSString *copyedString;

@end

@implementation FirstViewController

@synthesize firstName = _myfirstname;

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self firstTest];
    
//    [self createUI];
    
//    int a = 10;
//    NSLog(@"- %d -- %p", a, &a);

    //谓词筛选
//    [self methodPredicate];
    
   
}

 //谓词筛选
- (void)methodPredicate {
    
    @autoreleasepool {
        NSMutableArray *persons =[NSMutableArray arrayWithCapacity:0];
        
        for (int i=0; i<20; i++) {
            person *p = [[person alloc]init];
            p.age = i;
            [persons addObject:p];
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age<%d",10];
        
        //使用谓词条件过滤数组中的元素,过滤之后返回查询的结果
        NSArray *array = [persons filteredArrayUsingPredicate:predicate];
        
        ADLog(@"persons - %@",persons);
        
        ADLog(@"array - %@",array);
    }
}

- (void)createUI
{

    
    NSString *string = [NSString stringWithFormat:@"abc"];

//    NSMutableString *string = [NSMutableString stringWithFormat:@"abc"];
    self.strongString = [string mutableCopy];
    self.copyedString = [string mutableCopy];
    NSLog(@"---origin string: %@ %p, %p", string, string, &string);
    NSLog(@"---strong string: %@ %p, %p", self.strongString, self.strongString, &_strongString);
    NSLog(@"---copy string: %@ %p, %p", self.copyedString, self.copyedString, &_copyedString);
  
//    [string appendString:@"123"];
    string = @"123";

    NSLog(@"+++origin string:%@ %p, %p",string, string, &string);
    NSLog(@"+++strong string:%@ %p, %p", self.strongString,self.strongString, &_strongString);
    NSLog(@"+++copy string:%@ %p, %p", self.copyedString,self.copyedString, &_copyedString);
    
    //创建一个普通的Label
    UILabel *testLabel = [[UILabel alloc] init];
    //中央对齐
    testLabel.textAlignment = NSTextAlignmentCenter;
    testLabel.backgroundColor = [UIColor yellowColor];
    testLabel.numberOfLines = 0;
    testLabel.frame = CGRectMake(0, 200, self.view.frame.size.width, 30);
    [self.view addSubview:testLabel];
    
    //设置Attachment
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    //使用一张图片作为Attachment数据
    attachment.image = [UIImage imageNamed:@"tabbar_icon3_selected"];
    //这里bounds的x值并不会产生影响
    attachment.bounds = CGRectMake(-600, 0, 20, 20);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"这是一串字"];
    [attributedString insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
    
    testLabel.attributedText = attributedString;


}



- (void)firstTest1
{
    //    _myfirstname = @"123";
    //    ADLog(@"%@",_myfirstname);
    //    self.firstName = @"456";
    //    ADLog(@"%@",self.firstName);
    //    _myfirstname = @"789";
    //    ADLog(@"%@",_myfirstname);
    
    //    RunLoopObject1 *rl1 = [[RunLoopObject1 alloc]init];
    //
    //    NSTimer *timer1 = [NSTimer timerWithTimeInterval:1.0 target:rl1 selector:@selector(eat) userInfo:nil repeats:YES];
    //
    //    [[NSRunLoop currentRunLoop]addTimer:timer1 forMode:NSRunLoopCommonModes];
    
    
    
    //    NSString *md5str1 = @"12312313";
    //    md5str1 = md5str1.md5String;
    //    ADLog(@"%@",md5str1);
}
- (void)firstTest
{
//    NSString *str1 = @"1212";
//    NSString *str2 = [str1 copy];
//    NSString *str3 = [str1 mutableCopy];
//    ADLog(@"str1 -- %p",str1);
//    ADLog(@"str2 -- %p",str2);
//    ADLog(@"str3 -- %p",str3);
//
//    str1 = @"qqqqq";
//    ADLog(@"str1 -- %@",str1);
//    ADLog(@"str2 -- %@",str2);
//    ADLog(@"str3 -- %@",str3);
//
//    ADLog(@"str1 -- %p",str1);
//    ADLog(@"str2 -- %p",str2);
//    ADLog(@"str3 -- %p",str3);
    
    NSMutableString * string = [NSMutableString stringWithFormat:@"1"];
    NSString * copyString = [string copy];
    NSString * mutableCopyString = [string mutableCopy];
    NSLog(@"++string:%p - %@", string, string);
    NSLog(@"++copyString:%p - %@", copyString, copyString);
    NSLog(@"++mutableCopString:%p - %@", mutableCopyString, mutableCopyString);
    [string appendString:@",2"];
    NSLog(@"++string:%p - %@", string, string);
    NSLog(@"++copyString:%p - %@", copyString, copyString);
    NSLog(@"++mutableCopString:%p - %@", mutableCopyString, mutableCopyString);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
