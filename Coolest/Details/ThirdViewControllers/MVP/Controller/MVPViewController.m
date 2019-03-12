//
//  MVPViewController.m
//  Coolest
//
//  Created by daoj on 2019/3/11.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "MVPViewController.h"
#import "MVPProtocol.h"
#import "MVPPresent.h"
#import "MVPCell.h"

@interface MVPViewController ()<UITableViewDelegate,UITableViewDataSource,MVPProtocol>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic,strong) NSArray<MVPModel *> *friendlyUIData;

@property (nonatomic,strong) MVPPresent *presenter;

@end

@implementation MVPViewController

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height - kNavigationBarHeight) style:UITableViewStylePlain];
        
        _tableView.rowHeight = 60;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ContentBackColor;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, BottomEmptyHeight, 0);
    }
    return _tableView;
}
- (UIActivityIndicatorView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = self.view.center;
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (MVPPresent *)presenter {
    if (_presenter == nil) {
        _presenter = [[MVPPresent alloc] init];
        //绑定代理
        [_presenter attachView:self];
    }
    return _presenter;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.indicatorView];
    
    [self.presenter fetchData];
}


#pragma mark -- MVPProtocol
- (void)userViewDataSource:(NSArray<MVPModel *> *)data
{
    self.friendlyUIData = data;
    [self.tableView reloadData];
}

- (void)showIndicator
{
    [self.indicatorView startAnimating];
    self.indicatorView.hidden = NO;
}

- (void)hideIndicator
{
    [self.indicatorView stopAnimating];

}

- (void)showEmptyView
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert" message:@"show empty view" preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertView animated:YES completion:^{
        
    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friendlyUIData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    MVPCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[MVPCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    MVPModel *model = self.friendlyUIData[indexPath.row];
    cell.nameLabel.text = model.name;
    
    return cell;
}
@end
