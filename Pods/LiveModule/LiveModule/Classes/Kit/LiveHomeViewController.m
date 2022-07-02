//
//  LiveHomeViewController.m
//  Pods-LiveModule_Example
//
//  Created by LiChuanmin on 2022/7/2.
//

#import "LiveHomeViewController.h"
#import "LiveDetailViewController.h"

@interface LiveHomeViewController ()

@end

@implementation LiveHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.orangeColor;
    
    if (self.isGotoDetail) {
        [self push];
    }
}

- (void)push {
    LiveDetailViewController *vc = [[LiveDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
