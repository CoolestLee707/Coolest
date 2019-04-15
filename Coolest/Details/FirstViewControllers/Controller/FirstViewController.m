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
#import "HomeCell.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

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

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height - kNavigationBarHeight - BottomBarHeight) style:UITableViewStyleGrouped];
        
        _mainTableView.rowHeight = 70;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mainTableView.backgroundColor = ContentBackColor;
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_mainTableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:HomeCellId];
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"First";
    
    self.dataArray = @[@"北京",@"上海",@"广州",@"深圳",@"重庆",@"天津",@"苏州",@"成都",@"武汉",@"杭州",@"南京",@"长沙",@"郑州",@"西安",@"沈阳",@"合肥",@"青岛",@"大连",@"石家庄",@"太原",@"南昌",@"邢台"];
    [self createUI];
    
}

- (void)createUI
{
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
   
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = [NSString stringWithFormat:@"%ld--%@",(long)indexPath.row,self.dataArray[indexPath.row]];
    
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
