//
//  Service_OpenLiveHome.m
//  Pods-LiveModule_Example
//
//  Created by LiChuanmin on 2022/7/2.
//

#import "Service_OpenLiveHome.h"
#import "LiveHomeViewController.h"
#import "LiveDetailViewController.h"

#import "UIApplication+WBExtension.h"

@implementation Service_OpenLiveHome

- (void)action_OpenLive:(NSDictionary *)paramaters {
    LiveHomeViewController *vc = [[LiveHomeViewController alloc]init];

    if ([paramaters[@"isGotoDetail"] isEqualToString:@"1"]) {
        vc.isGotoDetail = YES;
    }
    UINavigationController *nav = [UIApplication wb_navigationController];
    [nav pushViewController:vc animated:YES];
}

- (void)action_OpenLiveDetail:(NSDictionary *)paramaters {
    LiveHomeViewController *vc = [[LiveHomeViewController alloc]init];    
    LiveDetailViewController *vc1 = [[LiveDetailViewController alloc]init];
    
    UINavigationController *nav = [UIApplication wb_navigationController];
    
    NSArray *arr = nav.viewControllers;
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:arr];
    [newArr addObject:vc];
    [newArr addObject:vc1];
    
//    nav.viewControllers = newArr;
    [nav setViewControllers:newArr animated:YES];
}
@end
