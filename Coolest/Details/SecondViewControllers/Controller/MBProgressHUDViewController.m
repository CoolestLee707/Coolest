//
//  MBProgressHUDViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "MBProgressHUDViewController.h"

@interface MBProgressHUDViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong) NSArray *dataArray;

@end

@implementation MBProgressHUDViewController

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height - kNavigationBarHeight) style:UITableViewStyleGrouped];
        
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
   
    self.title = @"MBProgressHUD封装使用";
    
    self.dataArray = @[@"成功",@"失败",@"一条消息",@"等待",@"加载",@"带文字加载"];
    [self createUI];
    
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
        cell.backgroundColor = TabbarColor;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = BaseBlueColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            [self showSuccess:@"成功"];
        }
            break;
        case 1:
        {
            [self showError:@"失败"];
        }
            break;
        case 2:
        {
            if (arc4random()%2) {
                [self showMessage:@"展示一条文字很多的消息，显示时间2.5秒"];
            }else {
                [self showMessage:@"展示一条短消息"];
                
            }
        }
            break;
        case 3:
        {
            [self showWaiting];
            [self afterMethod];
        }
            break;
        case 4:
        {
            [self showLoading];
            [self afterMethod];
        }
            break;
        case 5:
        {
            [self showLoadingWithMessage:@"拼命加载中。。。"];
            [self afterMethod];
        }
            break;
        default:
            break;
    }
    
}
#pragma mark---隐藏HUD
- (void)afterMethod {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHUD];
    });
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
