//
//  FileViewController.m
//  Coolest
//
//  Created by chuanmin li on 2021/8/17.
//  Copyright © 2021 CoolestLee707. All rights reserved.
//

#import "FileViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "WebViewPDFViewController.h"

NSString *filePath = @"https://wos4.58cdn.com.cn/nOUKjIhGfnpt/contract/e70d9058d8.pdf";

@interface FileViewController () {
    NSURLSessionDownloadTask *_downloadTask;
}
@property (strong, nonatomic) NSString *downfilePath;
@property (strong, nonatomic) UIButton *downLoadButton;
@property (strong, nonatomic) UIButton *watchButton;
@property (strong, nonatomic) UIButton *deleteButton;

@end

@implementation FileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"文件下载";
    
    [self setUpUI];
    
    [self setDownFile];
    
}

- (void)setUpUI {
    
    self.downLoadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downLoadButton.frame = CGRectMake(Main_Screen_Width/2 - 100, kNavigationBarHeight + 50, 200, 80);
    [self.view addSubview:self.downLoadButton];
    self.downLoadButton.backgroundColor = [UIColor yellowColor];
    [self.downLoadButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.downLoadButton addTarget:self action:@selector(downLoadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.watchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.watchButton.frame = CGRectMake(Main_Screen_Width/2 - 100, kNavigationBarHeight + 150, 200, 80);
    [self.watchButton setTitle:@"查看" forState:UIControlStateNormal];
    self.watchButton.backgroundColor = [UIColor yellowColor];
    [self.watchButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.watchButton addTarget:self action:@selector(watchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteButton.frame = CGRectMake(Main_Screen_Width/2 - 100, kNavigationBarHeight + 250, 200, 80);
    [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    self.deleteButton.backgroundColor = [UIColor yellowColor];
    [self.deleteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *cachesDownLoadPath = [NSString stringWithFormat:@"%@/downLoadFiles/e70d9058d8.pdf",cachesPath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachesDownLoadPath]) {
        
        [self.downLoadButton setTitle:@"下载完成" forState:UIControlStateNormal];
        [self.view addSubview:self.watchButton];
        [self.view addSubview:self.deleteButton];

    } else {
        [self.downLoadButton setTitle:@"下载" forState:UIControlStateNormal];
    }
    
}

- (void)deleteButtonClick {
    
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *cachesDownLoadPath = [NSString stringWithFormat:@"%@/downLoadFiles",cachesPath];
    NSString *newfilePath = [NSString stringWithFormat:@"%@/e70d9058d8.pdf",cachesDownLoadPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL fileExists=[[NSFileManager defaultManager] fileExistsAtPath:newfilePath];

    if (!fileExists) {
        return;
    }else {
        BOOL fileDele= [fileManager removeItemAtPath:newfilePath error:nil];
        if (fileDele) {
            [self showSuccess:@"删除成功"];
            [self.downLoadButton setTitle:@"下载" forState:UIControlStateNormal];
            [self.watchButton removeFromSuperview];
            [self.deleteButton removeFromSuperview];

        }else {
            [self showError:@"删除失败"];
        }
    }
    
}
- (void)downLoadButtonClick {
    
    if ([self.downLoadButton.titleLabel.text isEqualToString:@"下载"]) {
        [self setDownFile];
        [_downloadTask resume];
    }
}

- (void)watchButtonClick {
   
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *cachesDownLoadPath = [NSString stringWithFormat:@"%@/downLoadFiles",cachesPath];
    NSString *newfilePath = [NSString stringWithFormat:@"%@/e70d9058d8.pdf",cachesDownLoadPath];
    
    WebViewPDFViewController *vc = [[WebViewPDFViewController alloc]init];
    vc.filePath = newfilePath;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)setDownFile {
    
    NSURL *URL = [NSURL URLWithString:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
    
        ADLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.downLoadButton setTitle:[NSString stringWithFormat:@"下载中  %0.2f %%",100.00* downloadProgress.completedUnitCount / downloadProgress.totalUnitCount] forState:UIControlStateNormal];
        });
          
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        
//        这里将图片放在沙盒的caches文件夹中
        NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];

        NSString *cachesDownLoadPath = [NSString stringWithFormat:@"%@/downLoadFiles",cachesPath];

//        写文件时不存在可以自动创建文件夹，下载时不存在无法下载
        if ([[NSFileManager defaultManager] fileExistsAtPath:cachesDownLoadPath]) {
            //文件夹已存在
           
        } else {
            //创建文件夹
            [[NSFileManager defaultManager] createDirectoryAtPath:cachesDownLoadPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
            
        NSString *path = [cachesDownLoadPath stringByAppendingPathComponent:response.suggestedFilename];
        self.downfilePath = path;
        ADLog(@"self.downfilePath ---- %@",self.downfilePath);
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //设置下载完成操作
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        
        ADLog(@"filePath - %@",filePath);
        [self.downLoadButton setTitle:@"下载完成" forState:UIControlStateNormal];
        [self.view addSubview:self.watchButton];
        [self.view addSubview:self.deleteButton];
    }];
}
 
@end
