//
//  FourViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ADLog(@"%f--%f",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    
//    AVObject *testObject = [AVObject objectWithClassName:@"TestObject4"];
//    [testObject setObject:@"ttt" forKey:@"user"];
//    [testObject save];
    
    //创建一个普通的Label
    UILabel *testLabel = [[UILabel alloc] init];
    //中央对齐
    testLabel.textAlignment = NSTextAlignmentCenter;
    testLabel.backgroundColor = [UIColor yellowColor];
    testLabel.numberOfLines = 0;
    testLabel.frame = CGRectMake(0, 200, self.view.frame.size.width, 30);
    [self.view addSubview:testLabel];
    
    //设置Attachment
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    //使用一张图片作为Attachment数据
    attachment.image = [UIImage imageNamed:@"tabbar_icon3_selected"];
    //这里bounds的x值并不会产生影响
    attachment.bounds = CGRectMake(-600, 0, 20, 20);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"这是一串字"];
    [attributedString insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
    
    testLabel.attributedText = attributedString;

    // Do any additional setup after loading the view.
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    AVUser *user = [AVUser user];
//    user.username = @"jock";
//    user.password = @"123qwe";
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//
//        // 获取 RESTAPI 返回的错误信息详情（SDK 11.0.0 及以上的版本适用）
//        if ([error.domain isEqualToString:kLeanCloudErrorDomain] && error.code == 202) {
//
//            NSString *errorMessage = error.localizedFailureReason;
//            if (errorMessage) {
//                // handle error message
//            }
//        }
//    }];
//}
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
