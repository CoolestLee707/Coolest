//
//  FileViewController.m
//  Coolest
//
//  Created by chuanmin li on 2021/8/17.
//  Copyright © 2021 CoolestLee707. All rights reserved.
//

#import "FileViewController.h"
#import "AFNetworking/AFNetworking.h"
#import <WebKit/WebKit.h>

NSString *imagePath = @"/var/mobile/Containers/Data/Application/562A743A-CDB9-466D-93F1-09C56F7B1B31/Library/Caches/images/1629189346034_392.png";

@interface FileViewController ()<UIDocumentInteractionControllerDelegate> {
    NSURLSessionDownloadTask *_downloadTask;
}
@property (strong, nonatomic) WKWebView *wkWebView;
@property (strong, nonatomic) NSString *downfilePath;
@end

@implementation FileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    [self setDownFile];
    
    [self setupWebview];
}

- (void)setupWebview
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.selectionGranularity = WKSelectionGranularityDynamic;
    config.allowsInlineMediaPlayback = YES;
    [config.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    
    WKPreferences *preferences = [WKPreferences new];
    //是否支持JavaScript
    preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preferences;
    
    WKWebView *webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, Main_Screen_Width, Main_Screen_Height-kNavigationBarHeight) configuration:config];
    [self.view addSubview:webview];
    
    self.wkWebView = webview;
    
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
//    [self.wkWebView loadRequest:request];
}


- (void)buttonClick {
    [_downloadTask resume];
    
}
- (void)setDownFile {
    
//    NSURL *URL = [NSURL URLWithString:@"https://img1.baidu.com/it/u=1825851994,4163570429&fm=253&fmt=auto&app=120&f=JPEG?w=934&h=500"];
    
    NSURL *URL = [NSURL URLWithString:@"https://wos4.58cdn.com.cn/nOUKjIhGfnpt/contract/e70d9058d8.pdf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
    
        ADLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
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
        
//        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//        NSString *cachesDownLoadPath = [NSString stringWithFormat:@"%@/downLoadFiles",cachesPath];
//        NSString *path = [cachesDownLoadPath stringByAppendingPathComponent:response.suggestedFilename];
//        return [NSURL fileURLWithPath:path];

        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //设置下载完成操作
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        
        ADLog(@"filePath - %@",filePath);
    
//        读取加载沙盒文件
        NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *cachesDownLoadPath = [NSString stringWithFormat:@"%@/downLoadFiles",cachesPath];
        NSString *newfilePath = [NSString stringWithFormat:@"file://%@/e70d9058d8.pdf",cachesDownLoadPath];
        NSURL *newUrl = [NSURL URLWithString:newfilePath];
        ADLog(@"newUrl - %@",newUrl);

        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:newUrl]];
   
//        这个可以  file:///var/mobile/Containers/Data/Application/6C239EFB-5FED-4556-8CAA-F585A74FAC2E/Library/Caches/downLoadFiles/e70d9058d8.pdf
//        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:filePath]];
        
    }];
    
    
}


- (void)shareFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
       NSString *documentPath = [paths firstObject];
       NSString *cachePath = nil;
       NSFileManager *manager = [NSFileManager defaultManager] ;
       if (![manager fileExistsAtPath:documentPath]) {
           NSLog(@"没有文件");

       }else {
           NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:documentPath] objectEnumerator];
           NSString *fileName = nil;
           while ((fileName = [childFilesEnumerator nextObject]) != nil ){
               NSString* fileAbsolutePath = [documentPath stringByAppendingPathComponent:fileName];
               BOOL isDirectory = NO;
               NSLog(@"filePath %@", fileName);
               cachePath = [NSString stringWithFormat:@"%@/%@",documentPath, fileName];
               if ([manager fileExistsAtPath:fileAbsolutePath isDirectory:&isDirectory]){
                   NSDictionary *dic =  [manager attributesOfItemAtPath:fileAbsolutePath error:nil] ;
                   NSLog(@"%@", dic);
               }
               break;
           }
       }
       
       
       UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:imagePath]];
       documentController.delegate = self;
       documentController.name = @"喝喝";
       [documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
}
-(void)documentInteractionController:(UIDocumentInteractionController *)controller  willBeginSendingToApplication:(NSString *)application{
    
    
}
 
 
-(void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application{
    
}
 
 
-(void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller{
    
}
    
@end
