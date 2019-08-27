//
//  PresentOneViewController.m
//  Coolest
//
//  Created by daoj on 2019/1/14.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "PresentOneViewController.h"

@interface PresentOneViewController ()

@end

@implementation PresentOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];

    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
    UIViewController *controller = self;
    while(controller.presentingViewController != nil){
        controller = controller.presentingViewController;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}
-(void)dealloc
{
    
}

@end
