//
//  FirstViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "FirstViewController.h"
#import "RunLoopObject1.h"
#import "person.h"
#import "Son.h"
#import "HomeCell.h"
#import <Messages/Messages.h>
#import "NSObject+SwizzledMethod.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger count1;
    NSInteger count2;

}
@property (nonatomic,copy)NSString *firstName;

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,copy) NSArray *dataArray;

@property (nonatomic, strong) NSString *strongString;
@property (nonatomic, copy) NSString *copyedString;

@end

@implementation FirstViewController

@synthesize firstName = _myfirstname;

static NSString *HomeCellId = @"HomeCellId";

static IMP __origin_method_imp = nil;




- (UITableView *)mainTableView {
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height - kNavigationBarHeight - BottomBarHeight) style:UITableViewStyleGrouped];
        
        _mainTableView.rowHeight = 100;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mainTableView.backgroundColor = ContentBackColor;
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_mainTableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:HomeCellId];
    }
    return _mainTableView;
}

//递归函数
- (NSInteger)selectMaxNumberBig:(NSInteger)bigNumber Small:(NSInteger)smallNumber
{
    NSInteger a = bigNumber % smallNumber;
    if (a==0) {
        return smallNumber;
    }else {
        return [self selectMaxNumberBig:smallNumber Small:a];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSInteger aa = [self selectMaxNumberBig:168 Small:63];
    ADLog(@"+++-----%zd",aa);
    
    person *p = [[person alloc]init];
//    Son *s = [[Son alloc]init];
    
    [p eat];
//    [s eat];
    
    self.title = @"First";
    count1 = 0;
    count2 = 0;

    self.dataArray = @[@"北京",@"上海",@"广州",@"深圳",@"重庆",@"天津",@"苏州",@"成都",@"武汉",@"杭州",@"南京",@"长沙",@"郑州",@"西安",@"沈阳",@"合肥",@"青岛",@"大连",@"石家庄",@"太原",@"南昌",@"邢台"];
    
//    [self createUI];
    
//    ((void(*)(id, SEL))objc_msgSend)(self, @selector(createUI));

    
    id obj = [[NSObject alloc]init];
    
    ADLog("retain count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(obj)));
    
    
//    NSString *strtr = @"1212dshdhasjk sajhdkjas d sajkdh  dsajkhd kl h dsalh dakshd ";
//    self.copyedString = strtr;
//
//    ADLog(@"---%@",self.copyedString);
//
//    strtr = @"好吃健康证 块点饭啥看法 多少了开发的顺口溜发的啥开了房的时空裂缝手离开发电量将的史莱克";
//    ADLog(@"+++%@",self.copyedString);
    
    
}
+ (void)load
{
    [self swizzledInstanceSEL:@selector(createUI) withSEL:@selector(swizeCreateUI)];
    
//    Method orm = class_getInstanceMethod([self class], @selector(createUI));
//
//    __origin_method_imp = method_setImplementation(orm, class_getMethodImplementation(self, @selector(swizeCreateUI)));
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    ((void(*)(id, SEL))objc_msgSend)(self, @selector(createUI));
//    ((void(*)(id, SEL))__origin_method_imp)(self, _cmd);

}
- (void)createUI
{
//    assert([NSStringFromSelector(_cmd) isEqualToString:@"createUI"]);
    
    [self.view addSubview:self.mainTableView];
//    ADLog(@"_____________****  %@",NSStringFromSelector(_cmd));
    count1++;
//    ADLog(@"++++++++++ = %ld",count1);

    if (count1 < 5) {
        ADLog(@"++++++++++ = %ld",count1);
        [self createUI];

//         ((void(*)(id, SEL))__origin_method_imp)(self, _cmd);
    }
    
    

}


- (void)swizeCreateUI
{
    count2 ++;
    ADLog(@"-------- = %ld",count2);
    
    [[FirstViewController class] load];
    [self createUI];
//    ((void(*)(id, SEL))objc_msgSend)(self, @selector(swizeCreateUI));

    
//    ((void(*)(id, SEL))__origin_method_imp)(self, _cmd);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 14.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.nameLabel.text = [NSString stringWithFormat:@"%ld--%@",(long)indexPath.row,self.dataArray[indexPath.row]];
    
    kWeakSelf(WeakSelf);

    cell.clickBlock = ^(NSString * _Nonnull selectCity) {
        ADLog(@"%@",selectCity);
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
