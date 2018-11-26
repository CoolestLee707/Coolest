//
//  CameraViewController.m
//  Coolest
//
//  Created by daoj on 2018/11/23.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import "CameraViewController.h"
#import "CameraManager.h"

@interface CameraViewController ()

/** 背景视图 */
@property (nonatomic, strong) UIView *backView;
/** 按钮背景视图 */
@property (nonatomic, strong) UIView *menuBackView;
/** 录制/暂停按钮 */
@property (nonatomic, strong) UIButton *inputButton;
/**  左侧 返回/重录 按钮, */
@property (nonatomic, strong) UIButton *leftButton;
/** 右侧 切换/确认 按钮 */
@property (nonatomic, strong) UIButton *rightButton;
/** 拍摄管理类 */
@property (nonatomic, strong) CameraManager *manager;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initSubView];
    
    //初始化拍摄管理类
    self.manager = [[CameraManager alloc] initWithSuperView:self.backView];
    [self.manager openVideo];
    
}

/**
 初始化界面
 */
- (void)initSubView {
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    self.backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.backView];
    
    self.menuBackView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height - 100-BottomEmptyHeight, Main_Screen_Width, 100+BottomEmptyHeight)];
    [self.backView addSubview:self.menuBackView];
    self.menuBackView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    
    self.inputButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.inputButton.frame = CGRectMake((Main_Screen_Width - 60)/2, self.menuBackView.height/2 - 30, 60, 60);
    self.inputButton.backgroundColor = NavBackColor;
    self.inputButton.layer.cornerRadius = self.inputButton.width/2;
    self.inputButton.layer.masksToBounds = YES;
    [self.inputButton setBackgroundImage:[UIImage imageNamed:@"TakePhoto_shooting"] forState:UIControlStateNormal];
    [self.inputButton addTarget:self action:@selector(inputButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuBackView addSubview:self.inputButton];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(self.inputButton.left - 44-36, 0, 36, 36);
    self.leftButton.centerY = self.inputButton.centerY;
    
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"TakePhoto_down"] forState:UIControlStateNormal];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"TakePhoto_return"] forState:UIControlStateSelected];
    [self.leftButton setShowsTouchWhenHighlighted:false];
    [self.leftButton setAdjustsImageWhenHighlighted:false];
    [self.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuBackView addSubview:self.leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(self.inputButton.right+44, 0, 36, 36);
    self.rightButton.centerY = self.inputButton.centerY;
    
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"TakePhoto_switch"] forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"TakePhoto_complete"] forState:UIControlStateSelected];
    [self.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setShowsTouchWhenHighlighted:false];
    [self.rightButton setAdjustsImageWhenHighlighted:false];
    [self.menuBackView addSubview:self.rightButton];
}

/**
 录制/暂停按钮点击事件
 
 @param btn btn
 */
- (void)inputButtonClick:(UIButton *)btn{
    [self takePicture];
}

/**
 左侧 返回/重拍 按钮点击事件
 
 @param btn btn
 */
- (void)leftButtonClick:(UIButton *)btn{
    if (!btn.selected) {
        //返回方法
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        //移除重拍方法
        [self cannel];
    }
}

/**
 右侧 切换/确认 按钮点击事件
 
 @param btn btn
 */
- (void)rightButtonClick:(UIButton *)btn{
    if (!btn.selected) {
        //切换摄像头
        [self.manager exchangeCamera];
    }else{
        //确定
        if ([self.manager getOriginalImage]) {

            if (self.takeComplete) {
                self.takeComplete([self.manager getOriginalImage]);
            }
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


/**
 重拍
 */
- (void)cannel{
    [self.manager cannel];
    self.inputButton.hidden = false;
    self.leftButton.selected = false;
    self.rightButton.selected = false;
}

/**
 拍照
 */
- (void)takePicture{
    self.inputButton.hidden = true;
    [self.manager takePicture];
    self.leftButton.selected = true;
    self.rightButton.selected = true;
}


@end
