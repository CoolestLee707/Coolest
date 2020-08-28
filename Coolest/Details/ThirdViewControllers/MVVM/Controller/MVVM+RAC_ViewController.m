//
//  MVVM+RAC_ViewController.m
//  Coolest
//
//  Created by daoj on 2019/3/13.
//  Copyright © 2019 CoolestLee707. All rights reserved.

#import "MVVM+RAC_ViewController.h"
#import "MVVM_RAC_Service.h"

@interface MVVM_RAC_ViewController ()
{
    UIBarButtonItem *_editItem;

}
@property (nonatomic,strong) MVVM_RAC_ViewModel *vm;

@property (nonatomic,strong) UIButton *nextButton;


@property (nonatomic, strong) MVVM_RAC_Service *service;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MVVM_RAC_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"MVVM_RAC";
    
    [self createUI];

//    self.vm = [[MVVM_RAC_ViewModel alloc]init];
    
//    [self testRACSignal];
//
//    [self testRACSubject];
    
//    [self testRACReplaySubject];
    
//    [self testRACCommand];
}

#pragma mark -------- RACSignal
//RACSubscriber(订阅者), 用于发送信号, 这是一个协议不是一个类
//
//RACDisposable用于取消订阅或者清理资源, 当信号发送完成或发送错误的时候, 就会自动触发它
//RACSubject: 遵循了RACsubscriber协议的RACSignal,所以自己是信号, 也可以订阅其他信号
//
//RACReplaySubject: RACSubject的子类, 重复提供信号, 先把发送过的信号缓存起来, 再次订阅时直接发送缓存的值

//信号类RACSignal和RACSubject都遵守先订阅再发送信号原则, 但是RACReplaySubject可以先发送信号(内部是一个数组把信号保存起来), 再订阅, 因为它会把信号缓存起来
- (void)testRACSignal
{
    // 1:创建信号
    RACSignal*signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // 3:发送信号
        [subscriber sendNext:@"申请"];
        
        // 4:销毁信号
        return [RACDisposable disposableWithBlock:^{
            ADLog(@"销毁了");
        }];
    }];
    
    // 2:订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        ADLog(@"订阅信号 - %@",x);
    }];
}


#pragma mark -------- RACSubject
//RACSubject使用步骤
// 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
// 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
// 3.发送信号 sendNext:(id)value

// RACSubject:底层实现和RACSignal不一样。
// 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
// 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
- (void)testRACSubject
{
    //    1、创建信号
    RACSubject *subject = [RACSubject subject];
    
    //    2、订阅信号，RACSubject该对象会把订阅者放到之前创建的数组里面，然后啥都不做了
    [subject subscribeNext:^(id  _Nullable x) {
        // block调用时刻：当信号发出新值，就会调用.
        ADLog(@"第一个订阅者%@",x);
    }];
    
    [subject subscribeNext:^(id  _Nullable x) {
        // block调用时刻：当信号发出新值，就会调用.
        ADLog(@"第二个订阅者%@",x);
    }];
    
    //    3、发送信号，当他调用sendNext的时候，是会进行数组的遍历，然后挨个对订阅者发送消息
    [subject sendNext:@"1"];
    
}


#pragma mark -------- RACReplaySubject
// RACReplaySubject使用步骤:
// 1.创建信号 [RACReplaySubject subject]，跟RACSiganl不一样，创建信号时没有block。
// 2.可以先订阅信号，也可以先发送信号。
// 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
// 2.2 发送信号 sendNext:(id)value

// RACReplaySubject:底层实现和RACSubject不一样。
// 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
// 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock

// 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
// 也就是先保存值，在订阅值。

- (void)testRACReplaySubject
{
    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
}
#pragma mark -------- RACCommand
//RACCommand:RAC中用于处理事件的类, 可以把事件如何处理, 事件中的数据如何传递, 包装到这个类中, 可以很方便的监控事件的执行过程
/*RACCommand使用注意点
 1, 必须返回一个信号
 2, executionSignals: RACCommand返回的信号时信号中的信号, 有两种方式可以获取最新的信号
 - 1,switchToLatest: 获取内部的最新信号(被动执行)
 - 2,execute:        获取内部信号(这个是主动执行)
 3, executing        用来判断是否正在执行, 第一次不准确需要跳过
 4, 一定要记得sendCompleted, 否则永远不会执行完成
 */
- (void)testRACCommand
{
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.frame = CGRectMake(100, 100, 50, 50);
    _nextButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:_nextButton];
    
//    _nextButton.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//
//        ADLog(@"---%@",input);
//        UIButton *btn = (UIButton *)input;
//        btn.backgroundColor = [UIColor blueColor];
//
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//             //信号block
//            [subscriber sendNext:@"需要传出去的数据"];
//
//            return [RACDisposable disposableWithBlock:^{
//                 ADLog(@"销毁了");
//            }];
//        }];
//    }];
//
//
//    [_nextButton.rac_command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        ADLog(@"++++ %@",x);
//    }];
    
    
//    rac_signalForControlEvents: 监听某个事件
    [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ADLog(@"---");
    }];
    
    
//    rac_valuesAndChangesForKeyPath: 监听某个对象的属性变化(KVO)
    //注意:keypath(...) 的使用, 可以避免在观察者里面使用字符串, @keypath(self, age) == @"age"
//    [self rac_valuesForKeyPath:keypath(self, age) observer:self];
    //移除观察者还需要使用OC的方法
    
    
//    rac_addObserverForName: 监听某个通知
    //监听通知
    //不需要管理这个观察者, 不用去移除了
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"note" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    //发送通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"note" object:@"Never"];
    
//    rac_textSignal: 监听文本变化
}

- (void)createUI
{
    __weak typeof(self)WeakSelf = self;
    
    self.vm = [[MVVM_RAC_ViewModel alloc]initWithSuccess:^{
        
        ADLog(@"返回成功");
        [self showSuccess:@"成功"];
        [WeakSelf.tableView reloadData];
        
    } Faile:^{
        ADLog(@"返回失败");
        [self showSuccess:@"失败"];
    }];
    
    [self reload];
    
    [self.view addSubview:self.tableView];
    _editItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(reload)];

    _editItem.tintColor = [UIColor greenColor];
    self.navigationItem.rightBarButtonItem = _editItem;
}

- (MVVM_RAC_Service *)service
{
    if (!_service) {
        _service = [[MVVM_RAC_Service alloc] init];
        _service.viewModel = self.vm;
    }
    return _service;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height - kNavigationBarHeight) style:UITableViewStylePlain];
        
        _tableView.rowHeight = 60;
        _tableView.delegate = self.service;
        _tableView.dataSource = self.service;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ContentBackColor;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, BottomEmptyHeight, 0);
    }
    return _tableView;
}

- (void)reload
{
    [self showLoading];
    
    [self.vm getData];
}

@end
