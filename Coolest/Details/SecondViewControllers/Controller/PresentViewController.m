//
//  PresentViewController.m
//  Coolest
//
//  Created by daoj on 2019/1/14.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "PresentViewController.h"
#import "PresentOneViewController.h"

@interface PresentViewController ()

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"Present";
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
//
//    }];
//    ADLog(@"self.presentingViewController ---%@",self.presentingViewController);
//    [self dismissViewControllerAnimated:YES completion:^{
//
//    }];
    
    PresentOneViewController *vc = [[PresentOneViewController alloc]init];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:nil];
    
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
