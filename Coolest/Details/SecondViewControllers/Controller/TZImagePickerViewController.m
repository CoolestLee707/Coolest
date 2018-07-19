//
//  TZImagePickerViewController.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "TZImagePickerViewController.h"
#import "TZImagePickerController.h"

@interface TZImagePickerViewController ()<TZImagePickerControllerDelegate>

@end

@implementation TZImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TZImagePickerViewController";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    
    //    选择图片
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        ADLog(@"block选择图片-- %@ \n assets--%@\n isSelectOriginalPhoto--%d",photos,assets,isSelectOriginalPhoto);
    }];
    
    //    选择图片带图片信息
    [imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
        
        ADLog(@"block选择图片带图片信息-- %@ \n assets--%@\n infos-- %@ \n isSelectOriginalPhoto--%d",photos,assets,infos,isSelectOriginalPhoto);
        
    }];
    
    //    选择视频
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, id asset) {
        
        
    }];
    
    //    选择Gif
    [imagePickerVc setDidFinishPickingGifImageHandle:^(UIImage *animatedImage, id sourceAssets) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


#pragma mark ---- TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    ADLog(@"代理选择图片-- %@ \n assets--%@\n isSelectOriginalPhoto--%d",photos,assets,isSelectOriginalPhoto);
    
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos
{
    ADLog(@"代理选择图片带图片信息-- %@ \n assets--%@\n infos-- %@ \n isSelectOriginalPhoto--%d",photos,assets,infos,isSelectOriginalPhoto);
    
}

// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset
{
    
}

// 如果用户选择了一个gif图片，下面的handle会被执行
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset
{
    
}

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
