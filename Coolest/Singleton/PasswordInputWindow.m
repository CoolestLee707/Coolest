//
//  PasswordInputWindow.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "PasswordInputWindow.h"

@implementation PasswordInputWindow {
    
    UITextField *_textField;
}

+ (instancetype)shareInstance {
    
    static id shareInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareInstance = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
    });
    
    return shareInstance;
}

- (void)show {
    
    _textField.text = @"";
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
        textfield.borderStyle = UITextBorderStyleLine;
        [vc.view addSubview:textfield];
        _textField = textfield;
        
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
    
    if([_textField.text isEqualToString:@"11111"]) {
        [_textField resignFirstResponder];
        [self resignKeyWindow];
        self.hidden = YES;
    }else {
        [self showError];
    }
}

- (void)showError {
    [_textField resignFirstResponder];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"密码错误" message:@"正确密码11111" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    
    UIAlertAction *again = [UIAlertAction actionWithTitle:@"再试一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _textField.text = @"";
        [_textField becomeFirstResponder];
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
