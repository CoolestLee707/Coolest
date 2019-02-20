//
//  AsyncDisplayKitViewController.m
//  Coolest
//
//  Created by daoj on 2019/2/19.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "AsyncDisplayKitViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

#import "asyncTestCell.h"
#import "AsyncDisplayModel.h"

@interface AsyncDisplayKitViewController ()<ASTableDelegate,ASTableDataSource>

@property (nonatomic,strong)ASTableNode *tableNode;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation AsyncDisplayKitViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"Texture";

    [self setSubviews];
    
     [self loadData];
   
}

- (void)loadData
{
    NSString *str0 = @"这噢好哦的骄傲是冬季爱道具=";
    
    for (int i=0; i<20; i++) {
        
        AsyncDisplayModel *model = [[AsyncDisplayModel alloc]init];
        model.name = [NSString stringWithFormat:@"姓名%d",i];
        model.title = [NSString stringWithFormat:@"标题%d",i];
        model.content = [NSString stringWithFormat:@"内容%d-%@",i,str0];
        
        NSString *str1 = str0;
        for (int j=0; j<i; j++) {
            str1 = [str1 stringByAppendingString:str0];
        }
        int count = i%3;
        NSString *str2 = str0;
        for (int a=0; a<count; a++) {
            
            str2  = [str2 stringByAppendingString:str0];
        }
        model.descContent = [NSString stringWithFormat:@"描述--%d-%@",i,str2];

        model.detailContent = [NSString stringWithFormat:@"详细内容--%@",str1];
        
        [self.dataArray addObject:model];
    }
}

- (void)setSubviews {
    
//   1、 和 UITableView 一样，这句创建了 ASTableNode 实例，同时指定类型为 plain，因为我们决定使用自定义的表格。
    _tableNode = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
    
//   2、 设置 delegate 和 dataSource。
    self.tableNode.delegate = self;
    self.tableNode.dataSource = self;
    
//   3、tableNode 实际上封装了一个 UITableView，可以通过它的 .view 属性引用这个 UITableView，因此这句清除了表格分隔线。
    self.tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//   4、 addSubnode 是以 Category 形式添加的。其作用类似于 addSubview，不过它添加的是 ASNode 而不是 UIView。
    [self.view addSubnode:self.tableNode];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableNode.frame = CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height - kNavigationBarHeight);
    
}


#pragma mark --- ASTableDataSource
- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    
    return 1;
}
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASCellNode *(^cellNodeBlock)(void) = ^ASCellNode*() {
    
        AsyncDisplayModel *model = self.dataArray[indexPath.row];
        
        asyncTestCell* cellNode = [[asyncTestCell alloc]init];
        
//        cell.neverShowPlaceholders = YES;
        [cellNode drawCellWithData:model];
        
        return cellNode;
    };
    
    return cellNodeBlock;
}

/**
 这个方法用于告诉 ASTableNode，用户的一次下拉动作是否需要触发异步抓取，这里我们返回了 YES，也就是不管什么情况都进行异步抓取。我们这样做的原因，是现在的后台服务从来不告诉前端什么时候数据才会”完”,反正有数据的话服务器会返回数据，没数据的话则返回错误（比如“ 404 没有数据” 之类）或者返回空结果集。所以我们根本无法事先知道数据什么时候数据已经加载完。所以不管数据有没有完，我们都当做没有完来进行抓取，并通过服务器返回的结果来判断。这样这个方法就没有必要进行任何计算了，直接返回 YES。
 */
- (BOOL)shouldBatchFetchForTableNode:(ASTableNode *)tableNode {
    return YES;
}



/**
 这个方法用于进行一次抓取。loadPageWithContext: 方法是我们自定义的，它会加载一页数据，同时页数会累加，这样每次都会加载“下一页”，除非服务器没有数据返回。context 参数是必须的，用于抓取完后通知 ASTableNode 抓取完成（见后面的loadPageWithContext 方法实现)。
 */
- (void)tableNode:(ASTableNode *)tableNode willBeginBatchFetchWithContext:(ASBatchContext *)context {
    
    [context beginBatchFetching];
    [self loadPageWithContext:context];
}

// UITableView 的 cell 点击事件方法一模一样
- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AsyncDisplayModel *model = self.dataArray[indexPath.row];
    
    ADLog(@"%@-%@-%@-%zd",model.name,model.title,model.descContent,indexPath.row);
}

- (void)loadPageWithContext:(ASBatchContext *)context {
    
}

//在 dealloc 中释放 delegate 和 dataSource，据说这样可以避免闪退(实际有没有作用不得而知)
-(void)dealloc{
    self.tableNode.delegate = nil;
    self.tableNode.dataSource = nil;
}
@end
