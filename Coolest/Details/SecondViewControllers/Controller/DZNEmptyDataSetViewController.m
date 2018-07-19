//
//  DZNEmptyDataSetViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "DZNEmptyDataSetViewController.h"
#import "UIScrollView+EmptyDataSet.h"

typedef NS_ENUM(NSInteger,EMPTYTYPE) {
    EMPTYLOADING,
    EMPTYNODATA,
    EMPTYERROR,
};

@interface DZNEmptyDataSetViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,strong)UITableView *mainTableView;

@property(nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,assign)EMPTYTYPE emptyType;

@end

@implementation DZNEmptyDataSetViewController

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height - kNavigationBarHeight) style:UITableViewStyleGrouped];
        
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.backgroundColor = ContentBackColor;
        
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, BottomEmptyHeight, 0);
        _mainTableView.emptyDataSetSource = self;
        _mainTableView.emptyDataSetDelegate = self;
        
        _mainTableView.tableFooterView = [UIView new];
        
    }
    
    return _mainTableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"DZNEmptyDataSet";
    
    [self createUI];
    
    [self getData];
    
}

- (void)getData {
    
    [self showWaiting];
    
    self.emptyType = EMPTYLOADING;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //        NSInteger count = 0;
        //        do {
        //            [self.dataArray addObject:[NSString stringWithFormat:@"---- %zd",count]];
        //            count ++;
        //        } while (count < 20);
        
        if (!self.dataArray.count) {
            self.emptyType = EMPTYNODATA;
        }
        [self.mainTableView reloadData];
        [self hideHUD];
    });
    
}


- (void)createUI
{
    [self.view addSubview:self.mainTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = cellBackColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    
    return cell;
}

#pragma mark --- EmptyDataSet

//Asks to know if the empty state should be rendered and displayed (Default is YES)
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

//Asks for interaction permission (Default is YES)
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

//Asks for scrolling permission (Default is NO)
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    if (self.emptyType == EMPTYNODATA) {
        return [UIImage imageNamed:@"nodata-message"];
    }else if (self.emptyType == EMPTYERROR) {
        return [UIImage imageNamed:@"load_Error"];
    }
    return nil;
}
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"";
    
    if (self.emptyType == EMPTYNODATA) {
        text = @"没有数据";
    }
    if (self.emptyType == EMPTYERROR) {
        text = @"加载失败";
    }
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    
    if (self.emptyType == EMPTYERROR || self.emptyType == EMPTYNODATA) {
        return [[NSAttributedString alloc] initWithString:@"重试" attributes:attributes];
    }
    return nil;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    ADLog(@"tap");
    self.emptyType = EMPTYERROR;
    [self.mainTableView reloadEmptyDataSet];
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
