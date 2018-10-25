//
//  ThirdViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "ThirdViewController.h"
#import "CoolestCell.h"

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

    self.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18"];
    
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
