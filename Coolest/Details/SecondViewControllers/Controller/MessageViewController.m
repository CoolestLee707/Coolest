//
//  MessageViewController.m
//  Coolest
//
//  Created by daoj on 2018/11/27.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import "MessageViewController.h"
#import <MessageUI/MessageUI.h>

@interface MessageViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"信息";
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://15032268839"]];

    
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *msgVC = [[MFMessageComposeViewController alloc]init];

        msgVC.navigationBar.tintColor = [UIColor redColor];
        msgVC.messageComposeDelegate = self;
        msgVC.body = @"你好2121212" ;
        msgVC.recipients = @[@"15032268839"];
        [[[[msgVC viewControllers] lastObject] navigationItem] setTitle:@"自定义短信"];//修改短信界面标题

        [self presentViewController:msgVC animated:YES completion:NULL];
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }

}

@end
