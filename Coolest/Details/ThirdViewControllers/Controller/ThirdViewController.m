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
#import "SimpleFactoryPatternViewController.h"
//#import "HttpViewController.h"

#import "ImageEditViewController.h"
#import "InheritViewController.h"
#import "KVOViewController.h"
#import "RunLoopViewController.h"
#import "CLRouter.h"
#import "DrawRectViewController.h"
#import "HookViewController.h"
#import "ArithmeticViewController.h"
#import "CubeRouterViewController.h"

#import <UserNotifications/UserNotifications.h>

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
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    return _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Third";

//    [self Runloop];

    self.dataArray = @[@"1-拍照",@"2-消息转发",@"3-MVP",@"4-MVVM+RAC",@"5-RAC",@"6-简单工厂模式",@"7-Http",@"8",@"9",@"10-推送",@"11-sortedArrayUsingComparator",@"12-Inherit",@"13-KVO",@"14 - router",@"15 -RunLoop",@"16-DrawRect-绘制",@"17-hook",@"18-Arithmetic算法",@"19-CubeRouter",@"20 "];
    
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
        case 5 :
        {
            SimpleFactoryPatternViewController* vc = [[SimpleFactoryPatternViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6 :
        {
//            HttpViewController* vc = [[HttpViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 7 :
        {
            SimpleFactoryPatternViewController* vc = [[SimpleFactoryPatternViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 8 :
        {
            SimpleFactoryPatternViewController* vc = [[SimpleFactoryPatternViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 9:
        {
            [self addLocalNotice];
            break;
        }
        case 10:
        {
            [self sortedArrayUsingComparator];
            break;
        }
        case 11:
        {
            InheritViewController* vc = [[InheritViewController alloc]init];
//            vc.callBack = ^(NSString * _Nonnull result) {
//                ADLog(@"---- %@",result);
//            };
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 12:
        {
            KVOViewController* vc = [[KVOViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 13:
        {
            [[CLRouter sharedInstance] performTarget:@"KVOViewController" action:@"testRouter:age:" params:@{@"key":@"name"} shouldCacheTarget:NO];
            ADLog(@"CLRouter");
            break;
        }
        case 14:
        {
            RunLoopViewController* vc = [[RunLoopViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 15:
        {
            DrawRectViewController* vc = [[DrawRectViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 16:
        {
            HookViewController* vc = [[HookViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 17:
        {
            ArithmeticViewController* vc = [[ArithmeticViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 18:
        {
            CubeRouterViewController* vc = [[CubeRouterViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 19:
        {
//            BlockViewController* vc = [[CubeRouterViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
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

- (void)Runloop
{
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
}


- (void)addLocalNotice {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        // 标题
        content.title = @"新户专属会员礼包已为您备好，登录马上领取！您的新手会员礼包已到账，登录领取马上听！";
//        content.subtitle = @"测试通知副标题";
        // 内容
        content.body = @"免费畅听10000+精选故事，立即前往>>，《凯叔西游记》《神奇图书馆》《口袋神探》，立即给宝宝听>>，免费畅听10000+精选故事，立即前往>>，《凯叔西游记》《神奇图书馆》《口袋神探》，立即给宝宝听>>，免费畅听10000+精选故事，立即前往>>，《凯叔西游记》《神奇图书馆》《口袋神探》，立即给宝宝听>>";
        // 声音
       // 默认声音
         content.sound = [UNNotificationSound defaultSound];
     // 添加自定义声音
//       content.sound = [UNNotificationSound soundNamed:@"Alert_ActivityGoalAttained_Salient_Haptic.caf"];
        // 角标 （我这里测试的角标无效，暂时没找到原因）
        content.badge = @1;
        // 多少秒后发送,可以将固定的日期转化为时间
        NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:10] timeIntervalSinceNow];
//        NSTimeInterval time = 10;
        // repeats，是否重复，如果重复的话时间必须大于60s，要不会报错
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];
        
        /*
        //如果想重复可以使用这个,按日期
        // 周一早上 8：00 上班
        NSDateComponents *components = [[NSDateComponents alloc] init];
        // 注意，weekday默认是从周日开始
        components.weekday = 2;
        components.hour = 8;
        UNCalendarNotificationTrigger *calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
        */
        // 添加通知的标识符，可以用于移除，更新等操作
        NSString *identifier = @"noticeId";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            NSLog(@"成功添加推送");
        }];
    }else {
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        // 发出推送的日期
        notif.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
        // 推送的内容
        notif.alertBody = @"你已经10秒没出现了";
        // 可以添加特定信息
        notif.userInfo = @{@"noticeId":@"00001"};
        // 角标
        notif.applicationIconBadgeNumber = 1;
        // 提示音
        notif.soundName = UILocalNotificationDefaultSoundName;
        // 每周循环提醒
        notif.repeatInterval = NSCalendarUnitWeekOfYear;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
}

// 移除所有通知
- (void)removeAllNotification {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center removeAllPendingNotificationRequests];
    }else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

- (void)sortedArrayUsingComparator {
    
    NSArray *numberArray = @[@4,@5,@2,@6,@3,@7,@8];
    
    ADLog(@"numberArray - %@",numberArray);

     
    NSArray *array = [numberArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
//        我们对元素进行升序排序，比较integerValue
        NSNumber *number1 = obj1;
        NSNumber *number2 = obj2;
        if ([number1 integerValue] > [number2 integerValue]){
            return NSOrderedDescending;
        }else if([number1 integerValue] < [number2 integerValue]) {
            return NSOrderedAscending;
        }else{
            return NSOrderedSame;
        }
        
        // 数组逆转
//        return NSOrderedDescending;
//
//        // 数组不变
//        return NSOrderedAscending;
        
    }];
    
    ADLog(@"array - %@",array);
}
@end
