//
//  HitTestSubViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/7/20.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "HitTestSubViewController.h"

@interface HitTestSubViewController ()

@end

@implementation HitTestSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = false;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ADLog(@"%s",__func__);

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
