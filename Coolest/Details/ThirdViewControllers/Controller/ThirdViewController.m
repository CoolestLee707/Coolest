//
//  ThirdViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "ThirdViewController.h"
#import "CoolestCell.h"
#import "msgSendViewController.h"
#import "MVPViewController.h"
#import "MVVM+RAC_ViewController.h"
#import "RACViewController.h"

#import "ImageEditViewController.h"

@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,copy) NSArray *dataArray;

@end

@implementation ThirdViewController

#pragma mark --- Lazy

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height - kNavigationBarHeight - BottomBarHeight) style:UITableViewStyleGrouped];
        
        _mainTableView.rowHeight = 60;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mainTableView.backgroundColor = ContentBackColor;
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, BottomEmptyHeight, 0);
    }
    return _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Third";

//    typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
//        kCFRunLoopEntry = (1UL << 0),               // 即将进入Loop：1
//        kCFRunLoopBeforeTimers = (1UL << 1),        // 即将处理Timer：2
//        kCFRunLoopBeforeSources = (1UL << 2),       // 即将处理Source：4
//        kCFRunLoopBeforeWaiting = (1UL << 5),       // 即将进入休眠：32
//        kCFRunLoopAfterWaiting = (1UL << 6),        // 即将从休眠中唤醒：64
//        kCFRunLoopExit = (1UL << 7),                // 即将从Loop中退出：128
//        kCFRunLoopAllActivities = 0x0FFFFFFFU       // 监听全部状态改变
//    };
    
    // 创建观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"监听到RunLoop发生改变---%zd",activity);
    });
    
    // 添加观察者到当前RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    // 释放observer，最后添加完需要释放掉
    CFRelease(observer);
    
    
    @synchronized (self) {
        
    }
    self.dataArray = @[@"1-拍照",@"2-消息转发",@"3-MVP",@"4-MVVM+RAC",@"5-RAC",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18"];
    
    [self createUI];
}
- (void)createUI {
    [self.view addSubview:self.mainTableView];
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
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CoolestCell *cell = [CoolestCell CreateCoolestCell:tableView];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    switch (indexPath.row) {
        case 0 :
        {
            ImageEditViewController* vc = [[ImageEditViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
           
        case 1 :
        {
            msgSendViewController* vc = [[msgSendViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 2 :
        {
            MVPViewController* vc = [[MVPViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
           
        case 3 :
        {
            MVVM_RAC_ViewController* vc = [[MVVM_RAC_ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4 :
        {
            RACViewController* vc = [[RACViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
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
