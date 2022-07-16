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
#import <Messages/Messages.h>
#import "NSObject+SwizzledMethod.h"
#import "CLPermenantThread.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger count1;
    NSInteger count2;

}
@property (nonatomic,copy)NSString *firstName;

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,copy) NSArray *dataArray;

@property (strong, nonatomic) CLPermenantThread *CLPThread;

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

//    NSInteger aa = [self selectMaxNumberBig:168 Small:63];
//    ADLog(@"+++-----%zd",aa);
    
    self.title = @"First";
    count1 = 0;
    count2 = 0;

    self.dataArray = @[@"北京",@"上海",@"广州",@"深圳",@"重庆",@"天津",@"苏州",@"成都",@"武汉",@"杭州",@"南京",@"长沙",@"郑州",@"西安",@"沈阳",@"合肥",@"青岛",@"大连",@"石家庄",@"太原",@"南昌",@"邢台"];
    
//    [self createUI];
    
//    ((void(*)(id, SEL))objc_msgSend)(self, @selector(createUI));

    
//    id obj = [[NSObject alloc]init];
    
//    ADLog("retain count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(obj)));
    
}
+ (void)load {
    
//    方法交换
//    [self swizzledInstanceSEL:@selector(createUI) withSEL:@selector(swizeCreateUI)];
    
//    方法指针
    Method orm = class_getInstanceMethod([self class], @selector(createUI));
    __origin_method_imp = method_setImplementation(orm, class_getMethodImplementation(self, @selector(swizeCreateUI)));
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    objc_msgSend 调用方法
//    ((void(*)(id, SEL))objc_msgSend)(self, @selector(createUI));
    
//    方法指针直接调用，第一个参数receiver，第二个SEL
//    __origin_method_imp 指向createUI的方法实现
    ((void(*)(id, SEL))__origin_method_imp)(self, @selector(swizeCreateUI));

}
- (void)createUI {
//    assert([NSStringFromSelector(_cmd) isEqualToString:@"createUI"]);
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc]initWithTitle:@"恢复" style:UIBarButtonItemStyleDone target:self action:@selector(oldData)];

    editItem.tintColor = [UIColor greenColor];
    self.navigationItem.rightBarButtonItem = editItem;
    
    [self.view addSubview:self.mainTableView];
    [self.view layoutIfNeeded];
    
    self.CLPThread = [[CLPermenantThread alloc] init];

}

- (void)oldData {
    self.dataArray = @[@"北京",@"上海",@"广州",@"深圳",@"重庆",@"天津",@"苏州",@"成都",@"武汉",@"杭州",@"南京",@"长沙",@"郑州",@"西安",@"沈阳",@"合肥",@"青岛",@"大连",@"石家庄",@"太原",@"南昌",@"邢台"];
    [self.mainTableView reloadData];
    
    [self changeLightOrDark];
}
- (void)swizeCreateUI
{
//    [self swizeCreateUI];
//    ((void(*)(id, SEL))objc_msgSend)(self, @selector(swizeCreateUI));
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
   
    static NSString *cellId = @"HomeCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = TabbarColor;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = UIColor.blackColor;
    }
   
    cell.textLabel.text = [NSString stringWithFormat:@"%ld--%@",(long)indexPath.row,self.dataArray[indexPath.row]];
    
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
//    [self changeData];
    [self changeDataInDedaultMode];

}
#pragma mark 滑动过程中不想改变数据，可以把事件包装成一个port(定时器就行)，添加到defaultmode下
- (void)changeData {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        
        NSMutableArray *arr = @[].mutableCopy;
        for (int i=0; i<self.dataArray.count; i++) {
            [arr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        self.dataArray = [arr copy];
        sleep(5);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainTableView reloadData];
        });
    });
}
- (void)changeDataInDedaultMode {
 
    [self.CLPThread executeTask:^{
        NSLog(@"执行任务 - %@", [NSThread currentThread]);
        
        NSMutableArray *arr = @[].mutableCopy;
        for (int i=0; i<self.dataArray.count-1; i++) {
            [arr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        sleep(3);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadNewData:[arr copy]];
        });
       
    }];
}
- (void)reloadNewData:(NSArray *)newDatas {
    NSLog(@"reloadNewData - %@", [NSThread currentThread]);
    
    [self performSelector:@selector(reloadNewData11:) withObject:newDatas afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
    
}
- (void)reloadNewData11:(NSArray *)newDatas {
    NSLog(@"reloadNewData11 - %@", [NSThread currentThread]);
    self.dataArray = newDatas;
    [self.mainTableView reloadData];
}

// 手动切换Light和Dark
- (void)changeLightOrDark {
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
     if(@available(iOS 13.0, *)) {
        if (keyWindow.overrideUserInterfaceStyle == UIUserInterfaceStyleDark) {
            keyWindow.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        }else {
            keyWindow.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
        }
    }else {}
}
@end
