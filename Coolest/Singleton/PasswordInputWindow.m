//
//  PasswordInputWindow.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "PasswordInputWindow.h"

@interface PasswordInputWindow()

@property (nonatomic,strong)UITextField *passWordTextField;

@end

@implementation PasswordInputWindow

static id shareInstance = nil;

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareInstance = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
    });
    
    return shareInstance;
}
//2、重写allocWithZone方法，在调用alloc和allocWithZone方法产生的实例可能不是同一个实例，单例未真正实现
//+(instancetype)allocWithZone:(struct _NSZone *)zone {
//
//    static dispatch_once_t onceToken;
//       dispatch_once(&onceToken, ^{
//           shareInstance = [super allocWithZone:zone];
//       });
//       return shareInstance;
//}

- (void)show {
    
    self.passWordTextField.text = @"";
    [self.passWordTextField becomeFirstResponder];
    [self makeKeyAndVisible];
    self.hidden = NO;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIViewController *vc = [[UIViewController alloc] init];
        self.rootViewController = vc;
        vc.view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, Main_Screen_Width - 20, 50)];
        label.text = @"请输入密码";
        label.textColor = BaseBlueColor;
        label.font = [UIFont systemFontOfSize:20];
        label.backgroundColor = TabbarColor;
        label.textAlignment = NSTextAlignmentCenter;
        [vc.view addSubview:label];
        
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(100, 200, Main_Screen_Width - 200, 30)];
        textfield.backgroundColor = [UIColor yellowColor];
        textfield.textColor = BaseBlueColor;
        textfield.secureTextEntry = YES;
        textfield.keyboardType = UIKeyboardTypePhonePad;
        textfield.borderStyle = UITextBorderStyleLine;
        [vc.view addSubview:textfield];
        self.passWordTextField = textfield;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(Main_Screen_Width/2-30, 320, 80, 50);
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor greenColor]];
        [button setTitleColor:BaseBlueColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(completeClick) forControlEvents:UIControlEventTouchUpInside];
        [vc.view addSubview:button];
        
    }
    
    return self;
}

- (void)completeClick {
    
    if([self.passWordTextField.text isEqualToString:@"1"]) {
        [self.passWordTextField resignFirstResponder];
        [self resignKeyWindow];
        self.hidden = YES;
    }else {
        [self showError];
    }
}

- (void)showError {
    [self.passWordTextField resignFirstResponder];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"密码错误" message:@"正确密码1" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"再试一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.passWordTextField.text = @"";
        [self.passWordTextField becomeFirstResponder];
    }];
    [alertController addAction:again];
    
    [self.rootViewController presentViewController:alertController animated:YES completion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
