//
//  ImageEditViewController.m
//  Coolest
//
//  Created by daoj on 2018/11/23.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import "ImageEditViewController.h"
#import "CameraViewController.h"
#import "CameraManager.h"

@interface ImageEditViewController ()

@property(nonatomic,strong)UIImageView *resultImageView;

@end

@implementation ImageEditViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"TakePhoto";

    [self initSubviews];
    
}

- (void)initSubviews
{
    self.resultImageView = [[UIImageView alloc]init];
    [self.view addSubview:self.resultImageView];
    
    self.resultImageView.image = [UIImage imageNamed:@"TakePhoto_add"];
    self.resultImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(20+kNavigationBarHeight);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(self.resultImageView.mas_width).multipliedBy(PhotoMultiple);

    }];
    
    _resultImageView.layer.borderWidth = 3.0;
    _resultImageView.layer.borderColor = [[UIColor grayColor] CGColor];
    _resultImageView.userInteractionEnabled = YES;
    
    kWeakSelf(weakSelf);
    
    [_resultImageView setTapActionWithBlock:^{
       
        CameraViewController *vc = [[CameraViewController alloc]init];
        vc.takeComplete = ^(UIImage * resultImage) {
            
            weakSelf.resultImageView.image = resultImage;
            weakSelf.resultImageView.contentMode = UIViewContentModeScaleAspectFill;
        };
        [weakSelf presentViewController:vc animated:YES completion:nil];
        
    }];

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
    [self showLoadingWithMessage:@"图片保存中。。。"];

    CameraManager *manger = [[CameraManager alloc]init];
    [manger saveImageToLibrary:self.resultImageView.image Finish:^(BOOL result) {
        if (result) {
            [self showSuccess:@"图片保存成功"];
        }else {
            [self showSuccess:@"图片保存失败"];
        }
    }];
}
@end
