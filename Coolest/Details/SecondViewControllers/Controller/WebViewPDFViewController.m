//
//  WebViewPDFViewController.m
//  Coolest
//
//  Created by chuanmin li on 2021/8/23.
//  Copyright © 2021 CoolestLee707. All rights reserved.
//

#import "WebViewPDFViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewPDFViewController () <UIDocumentInteractionControllerDelegate> 

@property (strong, nonatomic) WKWebView *wkWebView;
@property(nonatomic,strong) UIDocumentInteractionController *documentController; //文档交互控制器

@end

@implementation WebViewPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"查看PDF";
    
    [self setupRightButton];
    
    [self setupWebview];

}

- (void)shareFile {

    ADLog(@"self.filePath -- %@",self.filePath);
//    本地资源文件
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"e70d9058d8.pdf" withExtension:nil];
    
//    沙盒文件
    NSURL *url = [NSURL fileURLWithPath:self.filePath];
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
    self.documentController.delegate = self;
    self.documentController.name = @"123.pdf";
    [self.documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
}

- (void)setupRightButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(shareFile) forControlEvents:UIControlEventTouchUpInside];
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setupWebview {
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
    
    
    NSString *newfilePath = [NSString stringWithFormat:@"file://%@",self.filePath];
    NSURL *newUrl = [NSURL URLWithString:newfilePath];
    ADLog(@"newUrl - %@",newUrl);

    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:newUrl]];
}

//文件分享面板弹出的时候调用
- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller {
    ADLog(@"WillPresentOpenInMenu");
}

//当选择一个文件分享App的时候调用
-(void)documentInteractionController:(UIDocumentInteractionController *)controller  willBeginSendingToApplication:(NSString *)application {
    ADLog(@"begin send : %@", application);
}
 
-(void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
}
 
//弹框消失的时候走的方法
-(void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller {
    ADLog(@"dissMiss");

}

@end
