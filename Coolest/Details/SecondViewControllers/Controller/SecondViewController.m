//
//  SecondViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "SecondViewController.h"
#import "ShareCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "WKWebviewViewController.h"
#import "MBProgressHUDViewController.h"
#import "DZNEmptyDataSetViewController.h"
#import "TZImagePickerViewController.h"

#define shareWidth  (Main_Screen_Width/3);

@interface SecondViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *shareCollectionView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SecondViewController

NSString *identifier = @"cell";
/**
 *  注册增补视图用的
 */
NSString *headerIdentifier = @"header";
NSString *footerIdentifier = @"footer";

#pragma mark -- lazy load
- (UICollectionView *)shareCollectionView {
    if (_shareCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumInteritemSpacing = 0;// 垂直方向的间距
        layout.minimumLineSpacing = 0; // 水平方向的间距
        
        layout.itemSize = CGSizeMake(Main_Screen_Width/3,Main_Screen_Width/3);
        
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _shareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height - BottomBarHeight - kNavigationBarHeight) collectionViewLayout:layout];
        _shareCollectionView.backgroundColor = [UIColor whiteColor];
        _shareCollectionView.dataSource = self;
        _shareCollectionView.delegate = self;
        
        _shareCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateNewdata)];
        
        [_shareCollectionView registerClass:[ShareCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
        [_shareCollectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
        
        
    }
    return _shareCollectionView;
}

- (void)updateNewdata
{
    NSLog(@"下拉。。。。");
    
    //    结束刷新
    //
    [_shareCollectionView.mj_header endRefreshing];
    //
    //    结束下拉加载
    //
    //    [Self.tableView.mj_footer endRefreshing]
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Second";
    
    self.dataArray = @[@[@"1-WKWebView",@"2-MBProgressHUD",@"3-DZNEmptyDataSetViewController"],@[@"4-TZImagePickerController",@"5-",@"6-"],@[@"7",@"8",@"9"],@[@"10",@"11",@"12"],@[@"13",@"14",@"15"],@[@"16",@"17",@"18"],@[@"19",@"20",@"21"]];
    
    [self createUI];
    
}

- (void)createUI
{
    //    // 是否显示垂直方向指示标, 继承于UIScrollView, 他的方法可以调用
    self.shareCollectionView.showsVerticalScrollIndicator = NO;
    
    // 添加到视图上
    [self.view addSubview:self.shareCollectionView];
    
    //    self.shareCollectionView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
    //
    //    UIView *baview = [[UIView alloc]initWithFrame:CGRectMake(0, -250, Main_Screen_Width, 250)];
    //    baview.backgroundColor = [UIColor redColor];
    //
    //    [self.shareCollectionView addSubview:baview];
    
}

#pragma mark collectionView代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr = self.dataArray[section];
    return arr.count;
}


/** 头部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGSizeMake(Main_Screen_Width, 280);
    }
    return CGSizeMake(Main_Screen_Width, CGFLOAT_MIN);
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareCollectionViewCell *cell = (ShareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //设置数据
    //    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    //    if (indexPath.section == 1) {
    //        cell.backgroundColor = [UIColor blueColor];
    //
    //    }
    
    NSArray *arr = self.dataArray[indexPath.section];
    [cell configData:arr[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    WKWebviewViewController* vc = [[WKWebviewViewController alloc]init];
                    vc.webUrl = @"https://www.baidu.com";
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case 1:
                {
                    MBProgressHUDViewController* vc = [[MBProgressHUDViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case 2:
                {
                    DZNEmptyDataSetViewController* vc = [[DZNEmptyDataSetViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                    
                default:
                    break;
            }
        }
            break;
            
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    TZImagePickerViewController* vc = [[TZImagePickerViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case 1:
                {
                   
                }
                    break;
                    
                case 2:
                {
                   
                }
                    break;
                    
                    
                default:
                    break;
            }
        }
            break;
            
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    
                }
                    break;
                    
                case 1:
                {
                    
                }
                    break;
                    
                case 2:
                {
                    
                }
                    break;
                    
                    
                default:
                    break;
            }
        }
            break;
            
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    
                }
                    break;
                    
                case 1:
                {
                    
                }
                    break;
                    
                case 2:
                {
                    
                }
                    break;
                    
                    
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
}

/** 头部/底部*/
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    // 如果是头视图
    if (kind == UICollectionElementKindSectionHeader) {
        // 从重用池里面取
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        headerView.backgroundColor =[UIColor orangeColor];
        return headerView;
    }
    return nil;
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
