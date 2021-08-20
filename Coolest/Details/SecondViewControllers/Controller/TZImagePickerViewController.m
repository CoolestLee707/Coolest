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
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    __block NSMutableArray *imagesArray = [NSMutableArray arrayWithCapacity:photos.count];
    
    if ([[TZImageManager manager] isVideo:assets[0]]) {
        //视频
        for (int i = 0; i < assets.count; i ++) {
            PHAsset *asset = assets[i];
            UIImage *image = photos[i];
            
            [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetMediumQuality success:^(NSString *outputPath) {
                NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
                
                // 时间戳，精度到毫秒
                double currentTime =  [[NSDate date] timeIntervalSince1970]*1000;
                NSString *strTime = [NSString stringWithFormat:@"%.0f",currentTime];
                // 随机数
                int randomValue = arc4random() % 1000;
                NSString *imageName = [NSString stringWithFormat:@"%@_%d.png",strTime,randomValue];
                NSString *videoName = [NSString stringWithFormat:@"%@_%d.mp4",strTime,randomValue];

                NSString *imageFilePath = [self getImagePath:image imageName:[NSString stringWithFormat:@"/%@",imageName]];
                
                
                NSData *imgData = UIImageJPEGRepresentation(image, 1.0f);
                NSUInteger imageSize = [imgData length];
                
                NSDictionary *dic = @{@"imageName":imageName,
                                      @"imagePath":imageFilePath,
                                      @"imageSize":@(imageSize),
                                      @"videoName":videoName,
                                      @"videoPath":outputPath,
                                      @"index":@(i),
                };
                
                [imagesArray addObject:dic];
               
                if (imagesArray.count == assets.count) {
                    
                    //排序
                    NSArray *sortArray = [imagesArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                        NSDictionary *dic1 = obj1;
                        NSDictionary *dic2 = obj2;
                        if ([dic1[@"index"] floatValue] > [dic2[@"index"] floatValue]) {
                            return NSOrderedDescending;//降序
                        }else if ([dic1[@"index"] floatValue] < [dic2[@"index"] floatValue]){
                            return NSOrderedAscending;//升序
                        }else {
                            return NSOrderedSame;//相等
                        }
                    }];
                    
                    NSDictionary *result = @{
                        @"code" : @0,
                        @"message" : @"",
                        @"videos" : sortArray,
                    };
              
                }
               
            } failure:^(NSString *errorMessage, NSError *error) {
                NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
            }];
        }
        
    }else {
        //图片
        for (UIImage *image in photos) {
            
            // 时间戳，精度到毫秒
            double currentTime =  [[NSDate date] timeIntervalSince1970]*1000;
            NSString *strTime = [NSString stringWithFormat:@"%.0f",currentTime];
            // 随机数
            int randomValue = arc4random() % 1000;
            NSString *imageName = [NSString stringWithFormat:@"%@_%d.png",strTime,randomValue];
            
            NSString *filePath = [self getImagePath:image imageName:[NSString stringWithFormat:@"/%@",imageName]];

            
            NSData *imgData = UIImageJPEGRepresentation(image, 1.0f);
            NSUInteger size = [imgData length];
            
            NSDictionary *dic = @{@"imageName":imageName,@"path":filePath,@"size":@(size)};

            [imagesArray addObject:dic];
        }
            
        NSDictionary *result = @{
            @"code" : @0,
            @"message" : @"",
            @"images" : imagesArray,
        };
 
    }
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

#pragma mark ---- 照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image imageName:(NSString *)imagePath {
    NSString *filePath = nil;
    NSData *data = nil;
    data = UIImageJPEGRepresentation(Image, 1.0f);
    //图片保存的路径
    //这里将图片放在沙盒的caches文件夹中
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    NSString *cachesImagesPath = [NSString stringWithFormat:@"%@/images",cachesPath];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:cachesImagesPath withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:[cachesImagesPath stringByAppendingString:imagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", cachesImagesPath, imagePath];
    return filePath;
}
@end
