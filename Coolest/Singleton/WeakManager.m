//
//  WeakManager.m
//  Coolest
//
//  Created by daoj on 2019/5/30.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "WeakManager.h"
#import "WKWebviewViewController.h"

@interface WeakManager () {
   __weak UIViewController *wtController;
}
@end

@implementation WeakManager

static id weakManager = nil;

+ (WeakManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weakManager = [[self alloc]init];
    });
   
    return weakManager;
}

- (void)openH5URLWithViewController:(UIViewController *)controller withURL:(NSString *)url
{
    wtController = controller;//不加w__week:controller又被强引用不会释放走delloc
    WKWebviewViewController* vc = [[WKWebviewViewController alloc]init];
    vc.webUrl = url;

    [wtController.navigationController pushViewController:vc animated:YES];
}
@end
